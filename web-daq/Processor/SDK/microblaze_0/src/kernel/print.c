#include "print.h"

#include <stdio.h>

void printLine(const char* str) {
	xil_printf("%s\r\n", str);
}

void printColorLine(const char* str, enum colors color) {
	if (color == RED) xil_printf("\033[31m%s\033[0m\r\n", str);
	else if (color == GREEN) xil_printf("\033[32m%s\033[0m\r\n", str);
	else if (color == YELLOW) xil_printf("\033[33m%s\033[0m\r\n", str);
	else if (color == BLUE) xil_printf("\033[34m%s\033[0m\r\n", str);
	else xil_printf("\r\n");
}

void printStatus(const char* str, enum colors color, const char* status) {
	xil_printf("%-50s", str);
	if (color == RED) xil_printf("[\033[31m%s\033[0m]\r\n", status);
	else if (color == GREEN) xil_printf("[\033[32m%s\033[0m]\r\n", status);
	else if (color == YELLOW) xil_printf("[\033[33m%s\033[0m]\r\n", status);
	else if (color == BLUE) xil_printf("[\033[34m%s\033[0m]\r\n", status);
	else xil_printf("\r\n");
}
