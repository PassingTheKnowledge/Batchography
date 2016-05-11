#include <stdio.h>

int fib(int n)
{
	if (n == 0 || n == 1)
		return n;
	else
		return fib(n-2) + fib(n-1);
}

int main(int argc, char *argv[])
{
	for (int i=1; i<=8; i++)
		printf("fib(%d)=%d\n", i, fib(i));

	return 0;
}