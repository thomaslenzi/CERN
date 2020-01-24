#ifndef CLIENTS_H_
#define CLIENTS_H_

#include "lwip/tcp.h"

struct websocket_connection {
	int id;
	struct tcp_pcb* tpcb;
};

void create_client(int, struct tcp_pcb*);
void remove_client(int);
struct websocket_connection* find_client(int);
void list_clients();
void clients_broadcast(char*, unsigned long long, int);
void clients_broadcast_butone(int, char*, unsigned long long, int);
void client_send(int, char*, unsigned long long, int);
unsigned long long text_to_frame(char*, char*, unsigned long long);
unsigned long long binary_to_frame(char*, char*, unsigned long long);

#endif
