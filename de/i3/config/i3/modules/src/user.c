#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pwd.h>

// 

int main(int argc, char *argv[])
{
    struct passwd *pass = getpwnam(getenv("USER"));

    pass->pw_gecos[strcspn(pass->pw_gecos, ",")] = '\0';

    printf("  %s\n", pass->pw_gecos);
}
