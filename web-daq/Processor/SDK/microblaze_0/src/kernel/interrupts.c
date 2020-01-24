#include "interrupts.h"

#include "xparameters.h"
#include "xintc.h"
#include "xtmrctr.h"
#include "lwip/tcp_impl.h"

void timer_callback() {
	static char odd = 1;
	tcp_fasttmr();
	odd = !odd;
	if (odd) tcp_slowtmr();
}

void xadapter_timer_handler(void* p) {
	timer_callback();
	XTmrCtr_SetControlStatusReg(XPAR_AXI_TIMER_0_BASEADDR, 0, XTC_CSR_INT_OCCURED_MASK | XTC_CSR_LOAD_MASK);
	XTmrCtr_SetControlStatusReg(XPAR_AXI_TIMER_0_BASEADDR, 0, XTC_CSR_ENABLE_TMR_MASK | XTC_CSR_ENABLE_INT_MASK | XTC_CSR_AUTO_RELOAD_MASK | XTC_CSR_DOWN_COUNT_MASK);
	XIntc_AckIntr(XPAR_INTC_0_BASEADDR, XPAR_AXI_TIMER_0_INTERRUPT_MASK);
}
