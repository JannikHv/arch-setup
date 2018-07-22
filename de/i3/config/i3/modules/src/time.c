#include <stdio.h>
#include <time.h>

// 

int main(int argc, char *argv[])
{
    time_t t = time(NULL);
    struct tm lt = *localtime(&t);

    printf(" %02d:%02d:%02d\n", lt.tm_hour, lt.tm_min, lt.tm_sec);
}
