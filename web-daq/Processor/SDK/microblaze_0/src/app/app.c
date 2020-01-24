#include "app.h"
#include "../websockets/clients.h"

#include <math.h>

void app() {

	static unsigned int i = 0;
	static unsigned int j = 0;
	double s;
	int t;

	if (i == 5000) {
		++j;
		s = sin(j) * 1000;
		t = (int) s;
		i = 0;
		clients_broadcast((char*) & t, 4, 2);
	}
	else ++i;
}
