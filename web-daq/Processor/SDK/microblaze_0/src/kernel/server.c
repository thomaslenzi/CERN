#include "server.h"
#include "print.h"
#include "request.h"

#include <stdio.h>

int start_server() {

	struct tcp_pcb* pcb;

	/*
	 * Setup the TCP protocol
	 */

	printColorLine("Setting up the TCP protocol...", BLUE);

	// Create new TCP PCB structure
	if (!(pcb = tcp_new())) {
		printStatus("> Creating the TCP PCB...", RED, "Failed");
		return 1;
	}
	printStatus("> Creating the TCP PCB...", GREEN, "OK");

	// Bind to specified @port
	if (tcp_bind(pcb, IP_ADDR_ANY, 80) != ERR_OK) {
		printStatus("> Binding to port...", RED, "Failed");
		return 1;
	}
	printStatus("> Binding to port...", GREEN, "OK");

	// We do not need any arguments to callback functions
	tcp_arg(pcb, NULL);

	// Listen for connections
	if (!(pcb = tcp_listen(pcb))) {
		printStatus("> Starting the TCP server...", RED, "Failed");
		return 1;
	}
	printStatus("> Starting the TCP server...", GREEN, "OK");
	printLine("");

	// Specify callback to use for incoming connections
	tcp_accept(pcb, accept_callback);

	return 0;
}

err_t accept_callback(void* arg, struct tcp_pcb* newpcb, err_t err) {

	static unsigned int connection = 1;

	// Accept the client
	tcp_accepted(newpcb);

	// Set the receive callback for this connection
	tcp_recv(newpcb, recv_callback);

	// Just use an integer number indicating the connection id as the callback argument
	tcp_arg(newpcb, (void*) connection);

	// increment for subsequent accepted connections
	++connection;

	return ERR_OK;
}

err_t recv_callback(void* arg, struct tcp_pcb* tpcb, struct pbuf* p, err_t err) {

	// Do not read the packet if we are not in ESTABLISHED state
	if (!p) {
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
		return ERR_OK;
	}

	// Indicate that the packet has been received
	tcp_recved(tpcb, p->len);

	// Process the request
	process_request((int) arg, tpcb, p);

	// Free the received pbuf
	pbuf_free(p);

	return ERR_OK;
}

int transfer_data() {
	return 0;
}
