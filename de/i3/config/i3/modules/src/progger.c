#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "utils/helper.h"

//   

int main(int argc, char *argv[])
{
    if (argc < 3) {
        exit(1);
    }

    const char *p_name = argv[1];
    const char *p_icon = argv[2];

    if (get_process_count_by_name(p_name) > 0) {
        printf("%s\n", p_icon);
    } else {
        printf("");
    }
}
