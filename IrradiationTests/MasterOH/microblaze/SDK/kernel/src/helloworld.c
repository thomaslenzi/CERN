/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include <xparameters.h>
#include <xgpio.h>

void print(char *str);

int main()
{
	XGpio gpio0, gpio1, gpio2, gpio3, gpio4;
	unsigned int a, b, c, d, e, f, g, h, i, j, k;

    init_platform();

    while (1) {
		XGpio_Initialize(&gpio0, XPAR_AXI_GPIO_0_DEVICE_ID);
		XGpio_Initialize(&gpio1, XPAR_AXI_GPIO_1_DEVICE_ID);
		XGpio_Initialize(&gpio2, XPAR_AXI_GPIO_2_DEVICE_ID);
		XGpio_Initialize(&gpio3, XPAR_AXI_GPIO_3_DEVICE_ID);
		XGpio_Initialize(&gpio4, XPAR_AXI_GPIO_4_DEVICE_ID);

		a = XGpio_DiscreteRead (&gpio0, 1); // Timer LSB
		b = XGpio_DiscreteRead (&gpio0, 2); // Timer MSB
		c = XGpio_DiscreteRead (&gpio1, 1); // BRAM Single
		d = XGpio_DiscreteRead (&gpio1, 2); // BRAM Double
		e = XGpio_DiscreteRead (&gpio2, 1); // DSP Global
		f = XGpio_DiscreteRead (&gpio2, 2); // DSP Single
		g = XGpio_DiscreteRead (&gpio3, 1); // DSP Double
		h = XGpio_DiscreteRead (&gpio3, 2); // DSP Triple
		i = XGpio_DiscreteRead (&gpio4, 1); // CLB Level1
		j = XGpio_DiscreteRead (&gpio4, 2); // CLB Level2

		printf("T\t%d%d\n\r", b, a);
		printf("BS\t%d\n\r", c);
		printf("BD\t%d\n\r", d);
		printf("DG\t%d\n\r", e);
		printf("DS\t%d\n\r", f);
		printf("DD\t%d\n\r", g);
		printf("DT\t%d\n\r", h);
		printf("C1\t%d\n\r", i);
		printf("C2\t%d\n\r", j);

		for (i = 0; i < 1000; ++i);
    }

    return 0;
}
