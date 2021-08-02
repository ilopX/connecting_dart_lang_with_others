#include "math.h"
#include <stdio.h>

int main() {
	int resultSum = sum(1, 2);
	printf("sum 1 + 2 = %d\n", resultSum);
	
	int val = 3;
	int resultSubstract = substract(&val, 2);
	printf("substract 3 - 2 = %d\n", resultSubstract);


	int* resultMulti = multiply(3, 3);
	printf("multiply 3 * 3 = %d\n", *resultMulti);
	free(resultMulti);

	int resultMultiSum = multi_sum(4, 1, 2, 3, 4);
	printf("multi_sum 1 + 2 + 3 + 4 = %d\n", resultMultiSum);

	return 0;
}