#ifndef REQUEST_H_
#define REQUEST_H_

#include "lwip/tcp.h"

#define RESPONSE_SIZE 1260

struct client_request {
	int id;
	unsigned char isHTTP;
	unsigned int status;
	char* method;
	char* path;
	char* type;
	unsigned char headerSize;
	char* headerName[40];
	char* headerContent[40];
	unsigned int bodyLength;
	char* bodyContent;
};

void process_request(int connection, struct tcp_pcb*, struct pbuf*);
void format_http_request(struct pbuf*, struct client_request*);
void format_websocket_request(struct pbuf*, struct client_request*);
unsigned char request_has_header(struct client_request*, char*);
char* request_get_header(struct client_request*, char*);
void request_dump(struct client_request*);

#endif
