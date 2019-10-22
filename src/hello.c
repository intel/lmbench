#include "bench.h"

int
main()
{
	(void) !write(1, "Hello world\n", 12);
	return (0);
}
