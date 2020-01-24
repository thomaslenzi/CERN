#ifndef PRINT_H_
#define PRINT_H_

enum colors {
	RED = 1,
	GREEN = 2,
	YELLOW = 3,
	ORANGE = 3,
	BLUE = 4
};

void printLine(const char*);
void printColorLine(const char*, enum colors);
void printStatus(const char*, enum colors, const char*);

#endif
