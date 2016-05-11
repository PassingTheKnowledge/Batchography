#include <stdio.h>

int main(int argc, char *argv[])
{
	int err = argc < 2 ? -1 : atoi(argv[1]);
	printf("returning %d\n", err);
	return err;
}