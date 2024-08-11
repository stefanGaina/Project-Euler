#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

#define TERMINATOR 999999999UL

int main(const int32_t argc, const char** const argv, const char* const envp)
{
	(void)argc;
	(void)argv;
	(void)envp;

	size_t stack[256] = {};
	size_t factor = 2UL;
	const size_t DIVIDER = 10UL;
	size_t carry = 0UL;
	size_t offset = 0UL;
	size_t result;
	size_t remainder;
	size_t digit;

	stack[0] = 1UL;
	stack[1] = TERMINATOR;

	do
	{
		do
		{
			digit  = stack[offset];
			digit *= factor;
			digit += carry;

			if (10UL <= digit)
			{
				carry  = digit / DIVIDER;
				digit %= DIVIDER;
			}
			else
			{
				carry = 0UL;
			}

			// printf("Digit: %lld\n", digit);
			stack[offset] = digit;
			++offset;
		}
		while (TERMINATOR != stack[offset]);
	
		while (0UL != carry)
		{
			digit  = carry % DIVIDER;
			carry /= DIVIDER;

			stack[offset] = digit;
			++offset;
		}

		stack[offset] = TERMINATOR;
		offset = 0UL;
		++factor;
	}
	while (100UL >= factor);

	result = 0UL;
	offset = 0UL;

	do
	{
		// printf("%lld ", stack[offset]);
		result += stack[offset];
		++offset;
	}
	while (TERMINATOR != stack[offset]);

	printf("\n%llu\n", result);
}
