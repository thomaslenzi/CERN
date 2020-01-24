#include "kernel/print.h"
#include "kernel/interrupts.h"
#include "kernel/server.h"
#include "app/app.h"

#include "xparameters.h"
#include "xil_cache.h"
#include "xintc.h"
#include "xtmrctr.h"
#include "mfs_config.h"
#include "netif/xadapter.h"
#include "lwip/init.h"

static XIntc intc;
static struct netif server_netif;

int main() {

	struct ip_addr ipaddr, netmask, gateway;
	unsigned char mac_ethernet_address[] = { 0x00, 0x0a, 0x35, 0x00, 0x01, 0x02 };
	unsigned int i;

	printLine("--------------------------------------------------");
	printLine("--                                              --");
	printLine("--            Microblaze Web Server             --");
	printLine("--                                              --");
	printLine("--    Developer: 							   --");
	printLine("--    Thomas Lenzi - thomas.lenzi@ulb.ac.be     --");
	printLine("--------------------------------------------------");

	/*
	 * Initialize the system
	 */

	printColorLine("Initializing the system...", BLUE);

	// Initialize the caches
	Xil_ICacheEnable();
	Xil_DCacheEnable();
	printStatus("> Enabling the caches...", GREEN, "OK");

	// Initialize the interrupt controller
	if (XIntc_Initialize((XIntc*) & intc, XPAR_INTC_0_DEVICE_ID) != XST_SUCCESS) {
		printStatus("> Initializing the interrupt controller...", RED, "Failed");
		return 1;
	}
	if (XIntc_Start((XIntc*) & intc, XIN_REAL_MODE) != XST_SUCCESS) {
		printStatus("> Initializing the interrupt controller...", RED, "Failed");
		return 1;
	}
	XIntc_MasterEnable(XPAR_INTC_0_BASEADDR);
	microblaze_register_handler((XInterruptHandler) XIntc_InterruptHandler, (XIntc*) & intc);
	printStatus("> Initializing the interrupt controller...", GREEN, "OK");

	// Initialize the timer
	XTmrCtr_SetLoadReg(XPAR_AXI_TIMER_0_BASEADDR, 0, 16500000);
	XTmrCtr_SetControlStatusReg(XPAR_AXI_TIMER_0_BASEADDR, 0, XTC_CSR_INT_OCCURED_MASK | XTC_CSR_LOAD_MASK );
	XTmrCtr_SetControlStatusReg(XPAR_AXI_TIMER_0_BASEADDR, 0, XTC_CSR_ENABLE_TMR_MASK | XTC_CSR_ENABLE_INT_MASK | XTC_CSR_AUTO_RELOAD_MASK | XTC_CSR_DOWN_COUNT_MASK);
	printStatus("> Initializing the timer...", GREEN, "OK");

	// Register Timer handler
	XIntc_RegisterHandler(XPAR_AXI_TIMER_0_BASEADDR, XPAR_INTC_0_TMRCTR_0_VEC_ID, (XInterruptHandler) xadapter_timer_handler, 0);

	// Enable the interrupts
	XIntc_Enable((XIntc*) & intc, XPAR_INTC_0_TMRCTR_0_VEC_ID);
	XIntc_Enable((XIntc*) & intc, XPAR_INTC_0_EMACLITE_0_VEC_ID);

	// Initialize the file system
    mfs_init_fs(MFS_NUMBYTES, (char*) (MFS_BASE_ADDRESS + 4), MFS_INIT_TYPE);
	printStatus("> Initializing MFS...", GREEN, "OK");

	/*
	 * Initialize the network
	 */

	printColorLine("Setting up the network interface...", BLUE);

	// Initialize IP addresses to be used
	IP4_ADDR((struct ip_addr*) & ipaddr, 192, 168, 1, 10);
	IP4_ADDR((struct ip_addr*) & netmask, 255, 255, 255, 0);
	IP4_ADDR((struct ip_addr*) & gateway, 192, 168, 1, 1);

	// Print application header
	xil_printf("> Board IP: %d.%d.%d.%d\n\r", ip4_addr1((struct ip_addr*) & ipaddr), ip4_addr2((struct ip_addr*) & ipaddr), ip4_addr3((struct ip_addr*) & ipaddr), ip4_addr4((struct ip_addr*) & ipaddr));
	xil_printf("> Netmask : %d.%d.%d.%d\n\r", ip4_addr1((struct ip_addr*) & netmask), ip4_addr2((struct ip_addr*) & netmask), ip4_addr3((struct ip_addr*) & netmask), ip4_addr4((struct ip_addr*) & netmask));
	xil_printf("> Gateway : %d.%d.%d.%d\n\r", ip4_addr1((struct ip_addr*) & gateway), ip4_addr2((struct ip_addr*) & gateway), ip4_addr3((struct ip_addr*) & gateway), ip4_addr4((struct ip_addr*) & gateway));

	// Initialize lwip
    printLine("> Initializing lwip...");
	lwip_init();

  	// Add network interface to the netif_list, and set it as default
	if (!xemac_add((struct netif*) & server_netif, (struct ip_addr*) & ipaddr, (struct ip_addr*) & netmask, (struct ip_addr*) & gateway, mac_ethernet_address, XPAR_ETHERNET_LITE_BASEADDR)) {
		printStatus("> Adding network interface...", RED, "Failed");
		return 1;
	}
	netif_set_default((struct netif*) & server_netif);
	printStatus("> Adding network interface...", GREEN, "OK");

	// Bring up the interface
	netif_set_up((struct netif*) & server_netif);
	printStatus("> Starting network interface...", GREEN, "OK");

	/*
	 * Enable the interrupts
	 */

	microblaze_enable_interrupts();

	/*
	 * Start the server
	 */

	start_server();

	/* Receive and process packets */
	i = 0;
	while (1) {
		app();
		xemacif_input((struct netif*) & server_netif);
		transfer_data();
	}

	/*
	 * Shutdown the system
	 */

	printLine("Shutting down the system...");

	Xil_DCacheDisable();
	Xil_ICacheDisable();

	return 0;
}
