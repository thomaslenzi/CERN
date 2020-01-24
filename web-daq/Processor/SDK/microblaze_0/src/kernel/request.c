#include "request.h"
#include "print.h"
#include "../websockets/websockets.h"
#include "../http/http.h"

#include <string.h>

void process_request(int connection, struct tcp_pcb* tpcb, struct pbuf* p) {

	struct client_request request;

	request.id = connection;

	if (strstr(p->payload, "HTTP") != NULL) {

		// Format the request
		format_http_request(p, (struct client_request*) & request);

		// Dispatch the request

		if (request_has_header((struct client_request*) & request, "Sec-WebSocket-Key") == 1) {
			websocket_handshake(tpcb, (struct client_request*) & request);
			printStatus(">> Request: WebSockets Handshake", GREEN, "Hi");
		}
		else {

			// Execute GET request
			request.status = http_get(tpcb, (struct client_request*) & request);

			// 404 response
			if (request.status == 404) {
				http_404(tpcb, (struct client_request*) & request);
				printStatus(">> Request: HTTP", RED, "404");
			}
			// 500 response
			else if (request.status == 500) {
				http_500(tpcb, (struct client_request*) & request);
				printStatus(">> Request: HTTP", RED, "500");
			}
			// 200 response
			else if (request.status == 200) printStatus(">> Request: HTTP", GREEN, "200");
			// Others ?
			else printStatus(">>Request: HTTP", RED, "Unknown");
		}

	}
	else {

		// Format the request
		format_websocket_request(p, (struct client_request*) & request);

		// Handle request
		request.status = websocket_input_frame(tpcb, (struct client_request*) & request);

		// Disconnected
		if (request.status == 8) printStatus(">> Request: WebSocket", GREEN, "Bye");
		// Text
		else if (request.status == 1) printStatus(">> Request: WebSocket", GREEN, "Text");
		// Binary
		else if (request.status == 2) printStatus(">> Request: WebSocket", GREEN, "Binary");
		// Failed
		else printStatus(">> Request: WebSocket", RED, "Unknown");
	}
}

void format_http_request(struct pbuf* p, struct client_request* request) {

	unsigned char length;

	request->isHTTP = 1;

	/*
	 * Format the body
	 */

	if ((request->bodyContent = strstr(p->payload, "\r\n\r\n")) != NULL) {
		*(request->bodyContent + 3) = 0; // Set the 3rd one to 0 so strtok will find last header
		request->bodyContent += 4;
		request->bodyLength = strlen(request->bodyContent) - 4;
		request->bodyContent[request->bodyLength] = 0; // Trim the end of the message
	}

	/*
	 * Format the request
	 */

	request->method = strtok((char*) p->payload, " ");
	request->path = strtok(NULL, " ");
	request->type = strtok(NULL, "\n");

	length = strlen(request->type);
	request->type[length - 1] = 0; // remove the \r at the end;

	request->headerSize = 0;

	while (1) {
		request->headerName[request->headerSize] = strtok(NULL, ":");
		if (request->headerName[request->headerSize] == NULL) break;
		request->headerContent[request->headerSize] = strtok(NULL, "\n");
		if (request->headerContent[request->headerSize]++ == NULL) break; // ++ removes space a the beginning
		length = strlen(request->headerContent[request->headerSize]);
		request->headerContent[request->headerSize][length - 1] = 0; // removes the \r at the end
		++request->headerSize;
	}
}

void format_websocket_request(struct pbuf* p, struct client_request* request) {
	request->isHTTP = 0;
	request->bodyLength = p->len;
	request->bodyContent = p->payload;
}

unsigned char request_has_header(struct client_request* request, char* header) {
	unsigned char i;
	for (i = 0; i < request->headerSize; ++i) {
		if (strcmp(request->headerName[i], header) == 0) return 1;
	}
	return 0;
}

char* request_get_header(struct client_request* request, char* header) {
	unsigned char i;
	for (i = 0; i < request->headerSize; ++i) {
		if (strcmp(request->headerName[i], header) == 0) return request->headerContent[i];
	}
	return NULL;
}

void request_dump(struct client_request* request) {
	unsigned char i;
	xil_printf("\r\n\r\nREQUEST DUMP\r\n");
	xil_printf("Method:%s\r\nPath: %s\r\nType:%s\r\n", request->method,  request->path,  request->type);
	for (i = 0; i < request->headerSize; ++i) xil_printf("%-20s : %s\r\n", request->headerName[i], request->headerContent[i]);
	xil_printf("Content: %s\r\n", request->bodyContent);
	xil_printf("\r\n\r\n");
}
