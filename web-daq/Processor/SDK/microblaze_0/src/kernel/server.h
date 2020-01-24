#ifndef SERVER_H_
#define SERVER_H_

#include "lwip/err.h"
#include "lwip/tcp.h"

int start_server();
err_t accept_callback(void*, struct tcp_pcb*, err_t);
err_t recv_callback(void*, struct tcp_pcb*, struct pbuf*, err_t);
int transfer_data();

#endif
