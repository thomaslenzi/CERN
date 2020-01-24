#include "clients.h"

#include <string.h>

#define NUMBER_OF_CLIENTS 100

struct websocket_connection websocket_clients[NUMBER_OF_CLIENTS];

void create_client(int id, struct tcp_pcb* tpcb) {
	unsigned int i;
	for (i = 0; i < NUMBER_OF_CLIENTS; ++i) {
		if (websocket_clients[i].id == id) return;
	}
	for (i = 0; i < NUMBER_OF_CLIENTS; ++i) {
		if (websocket_clients[i].id == 0) {
			websocket_clients[i].id = id;
			websocket_clients[i].tpcb = tpcb;
			return;
		}
	}
}

void remove_client(int id) {
	unsigned int i;
	for (i = 0; i < NUMBER_OF_CLIENTS; ++i) {
		if (websocket_clients[i].id == id) websocket_clients[i].id = 0;
	}
}

struct websocket_connection* find_client(int id) {
	unsigned int i;
	for (i = 0; i < NUMBER_OF_CLIENTS; ++i) {
		if (websocket_clients[i].id == id) return (struct websocket_connection*) & websocket_clients[i];
	}
	return NULL;
}

void list_clients() {
	unsigned int i;
	for (i = 0; i < NUMBER_OF_CLIENTS; ++i) {
		if (websocket_clients[i].id != 0) xil_printf("Client: %d\n\r", websocket_clients[i].id);
	}
}

void clients_broadcast(char* data, unsigned long long size, int type) {
	unsigned long long length;
	unsigned int i;
	int j;
	char* response;

	response = malloc(size + 10);
	if (type == 1) length = text_to_frame(data, response, size);
	else length = binary_to_frame(data, response, size);

	for (i = 0; i < NUMBER_OF_CLIENTS; ++i) {
		if (websocket_clients[i].id != 0) {
			tcp_write(websocket_clients[i].tpcb, response, length, 1);
			tcp_output(websocket_clients[i].tpcb);
		}
	}

	free(response);
}

void clients_broadcast_butone(int id, char* data, unsigned long long size, int type) {
	unsigned long long length;
	unsigned int i;
	char* response;

	response = malloc(size + 10);
	if (type == 1) length = text_to_frame(data, response, size);
	else length = binary_to_frame(data, response, size);

	for (i = 0; i < NUMBER_OF_CLIENTS; ++i) {
		if (websocket_clients[i].id != 0 && websocket_clients[i].id != id) {
			tcp_write(websocket_clients[i].tpcb, response, length, 1);
			tcp_output(websocket_clients[i].tpcb);
		}
	}

	free(response);
}

void client_send(int id, char* data, unsigned long long size, int type) {
	unsigned long long length;
	unsigned int i;
	char* response;

	response = malloc(size + 10);
	if (type == 1) length = text_to_frame(data, response, size);
	else length = binary_to_frame(data, response, size);

	for (i = 0; i < NUMBER_OF_CLIENTS; ++i) {
		if (websocket_clients[i].id == id) {
			tcp_write(websocket_clients[i].tpcb, response, length, 1);
			tcp_output(websocket_clients[i].tpcb);
		}
	}

	free(response);
}

unsigned long long text_to_frame(char* str, char* frame, unsigned long long size) {

	unsigned char length8b;
	unsigned short length16b;

	// Header
	frame[0] = 0x81;

	// Payload
	if (size > 65535) {
		frame[1] = 127;
		memcpy(frame + 2, (char*) & size, 8);
		memcpy(frame + 10, str, size);
		return size + 10;
	}
	else if (size > 125) {
		length16b = size;
		frame[1] = 126;
		memcpy(frame + 2, (char*) & length16b, 2);
		memcpy(frame + 4, str, length16b);
		return length16b + 4;
	}
	else {
		length8b = size;
		frame[1] = length8b;
		memcpy(frame + 2, str, length8b);
		return length8b + 2;
	}
}

unsigned long long binary_to_frame(char* str, char* frame, unsigned long long size) {

	unsigned char length8b;
	unsigned short length16b;

	// Header
	frame[0] = 0x82;

	// Payload
	if (size > 65535) {
		frame[1] = 127;
		memcpy(frame + 2, (char*) & size, 8);
		memcpy(frame + 10, str, size);
		return size + 10;
	}
	else if (size > 125) {
		length16b = size;
		frame[1] = 126;
		memcpy(frame + 2, (char*) & length16b, 2);
		memcpy(frame + 4, str, length16b);
		return length16b + 4;
	}
	else {
		length8b = size;
		frame[1] = length8b;
		memcpy(frame + 2, str, length8b);
		return length8b + 2;
	}
}
