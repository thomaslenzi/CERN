#ifndef WEBSOCKETS_H_
#define WEBSOCKETS_H_

#include "../kernel/request.h"

#include "lwip/tcp.h"

struct websocket_frame {
    unsigned char opcode;
    unsigned char maskUsed;
    unsigned long long payloadLength;
    unsigned char payloadBytesSize;
    char* maskingKey;
    char* payloadData;
};

void websocket_handshake(struct tcp_pcb*, struct client_request*);
int websocket_input_frame(struct tcp_pcb*, struct client_request*);
void format_websocket_frame(struct client_request*, struct websocket_frame*);
void frame_dump(struct websocket_frame*);

#endif
