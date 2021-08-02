#include "math.h"
#include <stdlib.h>
#include <stdarg.h>

int sum(int a, int b) {
	return a + b;
}

int substract(int* a, int b) {
	return *a - b;
}

int* multiply(int a, int b)
{
	int* result = (int*)malloc(sizeof(int));
	*result = a * b;
	return result;
}

int multi_sum(int n_count, ...)
{
    va_list nums;
    va_start(nums, n_count);
    int sum = 0;
    for (int i = 0; i < n_count; i++)
    {
        sum += va_arg(nums, int);
    }
    va_end(nums);
    return sum;
}
