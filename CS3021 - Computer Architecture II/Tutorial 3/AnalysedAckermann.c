#include <stdio.h>
#include <time.h>

int maxDepth = 0;
int calls = 0;
int flows[3] = {0, 0, 0};

int ackermann(int x, int y, int depth) {
	
	calls++;
	maxDepth = (depth > maxDepth) ? depth : maxDepth;
	if (depth > 6) flows[0]++;
	if (depth > 8) flows[1]++;
	if (depth > 16) flows[2]++;

	if (x == 0)
		return y + 1;
	else if (y == 0)
		return ackermann(x - 1, 1, depth + 1);
	else
		return ackermann(x - 1, ackermann(x, y - 1, depth + 1), depth + 1);
	
}

int main(int agrc, char** argv) {

	ackermann(3, 6, 3); // 1 + (2 necessary RWs)

	printf("Max Depth: %d\n", maxDepth - 2);
	printf("Max Depth (incl. 2 necessary RWs): %d\n", maxDepth);
	printf("Procedure Calls: %d\n", calls);
	printf("Overflows/Underflows: RS-6 = %d, RS-8 = %d, RS-16 = %d\n", flows[0], flows[1], 
flows[2]);

}
