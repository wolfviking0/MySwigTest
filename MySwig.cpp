#include "MySwig.h"

using namespace Test;

MySwig::MySwig()
{
}

std::string MySwig::version()
{
    return "0.0.0";
}

int MySwig::setMem(int size, unsigned char *ptr)
{
	printf("AL --> Change the value of the array ...\n");

	for (int i = 0 ; i < size ; i++) {
		ptr[i] = i;
	}

    return size;
}
