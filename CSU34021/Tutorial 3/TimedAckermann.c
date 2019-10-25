#include <stdio.h>
#include <time.h>

const int RUNS = 100;

int ackermann(int x, int y) {
	if (x == 0)
		return y + 1;
	else if (y == 0)
		return ackermann(x - 1, 1);
	else
		return ackermann(x - 1, ackermann(x, y - 1));
}

int main(int argc, char** argv) {
	
	int result;
	int totalTime = 0;

	struct timeval begin, end;	

	for (int i = 0; i < RUNS; i++) {

		gettimeofday(&begin, NULL);
		result = ackermann(3, 6);	
		gettimeofday(&end, NULL);
		
		totalTime += ((end.tv_sec - begin.tv_sec) * 1000000) + (end.tv_usec - 
begin.tv_usec);
		
	}

	double avgTime = totalTime / (double) RUNS;

	printf("ackermann(3, 6) = %d\nTook %.2f microseconds on average to execute\n", result, 
avgTime);
	
}
