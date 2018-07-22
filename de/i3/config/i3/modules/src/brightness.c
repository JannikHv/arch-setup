#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "utils/helper.h"

// 

#define BACKLIGHT_DIR_DEFAULT "/sys/class/backlight/acpi_video0/"

int main(int argc, char *argv[])
{
    if (!dir_exists(BACKLIGHT_DIR_DEFAULT)) {
        exit(1);
    }

    int res;
    float now, max;
    char tmp_path_now[512], tmp_path_max[512];

    sprintf(tmp_path_now, "%s%s", BACKLIGHT_DIR_DEFAULT, "brightness");
    sprintf(tmp_path_max, "%s%s", BACKLIGHT_DIR_DEFAULT, "max_brightness");

    now = atof(read_file_from_path(tmp_path_now));
    max = atof(read_file_from_path(tmp_path_max));
    res = (int) round(now / max * 100);

    printf(" %d%\n", res);
}
