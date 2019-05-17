#ifndef __TEST_API_H_
#define __TEST_API_H_

#include <vector>
#include <string>

namespace Test
{
    class MySwig
    {

    public:

        MySwig();

        ~MySwig();

        static std::string version();

        int setMem(int size, unsigned char *ptr);
    };
}

#endif 
