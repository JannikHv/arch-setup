#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "utils/helper.h"

//       

#define BAT_PATH_DEFAULT  "/sys/class/power_supply/BAT0"
#define BAT_PATH_CAPACITY "/sys/class/power_supply/BAT0/capacity"
#define BAT_PATH_STATUS   "/sys/class/power_supply/BAT0/status"

typedef enum {
    BAT_LEVEL_EMPTY,
    BAT_LEVEL_LOW,
    BAT_LEVEL_HALF,
    BAT_LEVEL_HIGH,
    BAT_LEVEL_FULL,
    BAT_LEVEL_UNKNOWN
} BatLevel;

typedef struct {
    int       capacity;
    bool      charging;
    BatLevel  level;
} BatInfo;

static const char *bat_level_symbol[] = {
    " ", " ", " ", " ", " ", ""
};

static const char *bat_charging_symbol[] = {
    "\0", ""
};

static BatLevel battery_info_get_level(BatInfo *bat_info)
{
    switch (bat_info->capacity) {
        case 0 ... 19:
            return BAT_LEVEL_EMPTY;
        case 20 ... 39:
            return BAT_LEVEL_LOW;
        case 40 ... 59:
            return BAT_LEVEL_HALF;
        case 60 ... 79:
            return BAT_LEVEL_HIGH;
        case 80 ... 100:
            return BAT_LEVEL_FULL;
        default:
            return BAT_LEVEL_UNKNOWN;
    }
}

static BatInfo *battery_info_get_default(void)
{
    BatInfo *bat_info;
    const char *status;

    bat_info = (BatInfo *) malloc(sizeof(BatInfo));

    status = read_file_from_path(BAT_PATH_STATUS);

    bat_info->capacity = atoi(read_file_from_path(BAT_PATH_CAPACITY));
    bat_info->charging = (strcmp(status, "Discharging") == 0) ? false : true;
    bat_info->level    = battery_info_get_level(bat_info);

    return bat_info;
}

int main(int argc, char *argv[])
{
    if (!dir_exists(BAT_PATH_DEFAULT)) {
        exit(1);
    }

    BatInfo *bat_info = battery_info_get_default();

    printf("%s %s %d%\n", bat_charging_symbol[bat_info->charging],
                          bat_level_symbol[bat_info->level],
                          bat_info->capacity);
}
