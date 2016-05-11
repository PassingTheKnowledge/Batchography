#include <stdio.h>
#include <stdlib.h>

int main()
{
	char buf[100];

	printf("Enter a string:");
	char *input = gets_s(buf, _countof(buf));
	if (input != NULL)
	{
		while (*input != '\0')
			printf("%c\n", *input++);
	}
	return 0;
}