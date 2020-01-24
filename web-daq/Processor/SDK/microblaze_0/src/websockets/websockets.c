#include "websockets.h"
#include "sha1.h"
#include "base64.h"
#include "clients.h"

#include <string.h>

const char secret[] = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";
struct websocket_connection* websocket_clients;

void websocket_handshake(struct tcp_pcb* tpcb, struct client_request* request) {

	char responseBuffer[RESPONSE_SIZE];
	unsigned int responseLength;
	char stringBuffer[64];
	char shaHash[20] = { 0 };
	char* key;
	unsigned int keyLength;
	char* responseKey;
	unsigned int secretLength;

	key = request_get_header(request, "Sec-WebSocket-Key");
	keyLength = strlen(key);
	secretLength = strlen(secret);
	responseKey = malloc(keyLength + secretLength);

	// Compute response key
    memcpy(responseKey, key, keyLength);
    memcpy((char*) (responseKey + keyLength), secret, secretLength);
    sha1(shaHash, responseKey, (keyLength + secretLength) * 8);
    base64enc(responseKey, shaHash, 20);

	// Format header
    strcpy(responseBuffer, "HTTP/1.1 101 Switching Protocols\r\n");
	strcat(responseBuffer, "Upgrade: websocket\r\n");
	strcat(responseBuffer, "Connection: Upgrade\r\n");
    sprintf(stringBuffer, "Sec-WebSocket-Accept: %s\r\n\r\n", responseKey);
    strcat(responseBuffer, stringBuffer);
    responseLength = strlen(responseBuffer);

	// Free memory
	free(responseKey);

	// Send data
	tcp_write(tpcb, responseBuffer, responseLength, 1);

	// Create the client
	create_client(request->id, tpcb);
}

int websocket_input_frame(struct tcp_pcb* tpcb, struct client_request* request) {

	struct websocket_frame frame;

	format_websocket_frame(request, (struct websocket_frame*) & frame);

	// Remove the client
	if (frame.opcode == 0x8) {
		remove_client(request->id);
		return 8;
	}
	// Text
	else if (frame.opcode == 0x1) {
		clients_broadcast(frame.payloadData, frame.payloadLength, 1);
		return 1;
	}
	// Binary
	else if (frame.opcode == 0x8) {

		return 2;
	}

	return 0;
}

void format_websocket_frame(struct client_request* request, struct websocket_frame* frame) {

	unsigned char length8b;
	unsigned short length16b;
	unsigned long long length64b;
	unsigned long long i;

	// Header
	frame->opcode = request->bodyContent[0] & 0xf;
	frame->maskUsed = (request->bodyContent[1] & 0x80) >> 7;

	// Payload size
	length8b = request->bodyContent[1] & 0x7f;
	if (length8b == 126) {
		memcpy((char*) & length16b, request->bodyContent + 2, 2);
		frame->payloadBytesSize = 2;
		frame->payloadLength = length16b;
	}
	else if (length8b == 127) {
		memcpy((char*) & length64b, request->bodyContent + 2, 8);
		frame->payloadBytesSize = 8;
		frame->payloadLength = length64b;
	}
	else {
		frame->payloadBytesSize = 0;
		frame->payloadLength = length8b;
	}

	// Masking key
	if (frame->maskUsed == 1) frame->maskingKey = request->bodyContent + frame->payloadBytesSize + 2;

	// Data
	frame->payloadData = frame->maskingKey + 4;
	for (i = 0; i < frame->payloadLength; ++i) frame->payloadData[i] = frame->payloadData[i] ^ frame->maskingKey[i % 4];
}

void frame_dump(struct websocket_frame* frame) {
	unsigned long long i;
	xil_printf("\r\n\r\nFRAME DUMP\r\n");
	xil_printf("OPCode: %d\r\nMasking: %d\r\nLength: %d\r\n", frame->opcode,  frame->maskUsed, frame->payloadLength);
	for (i = 0; i < frame->payloadLength; ++i) xil_printf("%c", frame->payloadData[i]);
	xil_printf("\r\n\r\n");
}
