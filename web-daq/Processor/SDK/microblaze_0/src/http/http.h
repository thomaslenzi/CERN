#ifndef HTTP_H_
#define HTTP_H_

#include "../kernel/request.h"

#include "lwip/tcp.h"

void http_echo(struct tcp_pcb*, struct client_request*);
int http_get(struct tcp_pcb*, struct client_request*);
void http_404(struct tcp_pcb*, struct client_request*);
void http_500(struct tcp_pcb*, struct client_request*);

#endif
