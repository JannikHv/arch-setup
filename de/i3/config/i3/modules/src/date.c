#include <stdio.h>
#include <time.h>

// 

int main(int argc, char *argv[])
{
    time_t t = time(NULL);
    struct tm lt = *localtime(&t);
    const char *day_name[] = {
        "Sun", "Mon", "Tue", "Wed",
        "Thu", "Fri", "Sat"
    };

    printf(" %s %02d.%02d.%04d\n", day_name[lt.tm_wday], lt.tm_mday, lt.tm_mon + 1, lt.tm_year + 1900);
}
