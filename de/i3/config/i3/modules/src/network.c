#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <net/if.h>
#include <arpa/inet.h>

#include "utils/helper.h"

//  

#define NET_DIR_DEFAULT "/sys/class/net/"

typedef enum {
    NET_TYPE_WIRELESS,
    NET_TYPE_WIRED
} NetType;

typedef struct {
    const char *device_name;
    const char *ipv4;
    NetType     type;
} NetInfo;

static const char *net_type_symbol[] = {
    "", ""
};

static NetType net_get_device_type(const char *device_name)
{
    char tmp_path[512];

    sprintf(tmp_path, "%s%s%s", NET_DIR_DEFAULT, device_name, "/wireless");

    return (dir_exists_from_path(tmp_path)) ? NET_TYPE_WIRELESS : NET_TYPE_WIRED;
}

static bool net_get_device_active(const char *device_name)
{
    char tmp_path[512];
    const char *operstate;

    sprintf(tmp_path, "%s%s%s", NET_DIR_DEFAULT, device_name, "/operstate");

    operstate = read_file_from_path(tmp_path);

    return (strcmp(operstate, "up") == 0) ? true : false;
}

static const char *net_get_active_device_name(void)
{
    struct dirent *ent;
    DIR *dir;
    char tmp_path[512];

    dir = opendir(NET_DIR_DEFAULT);

    while ((ent = readdir(dir)) != NULL) {
        sprintf(tmp_path, "%s%s%s", NET_DIR_DEFAULT, ent->d_name, "/device");

        if (dir_exists_from_path(tmp_path) && net_get_device_active(ent->d_name)) {
            return ent->d_name;
        }
    }

    return NULL;
}

static NetInfo *net_info_get_default(void)
{
    NetInfo *net_info;
    int fd;
    struct ifreq ifr;
    const char *active_device_name = net_get_active_device_name();

    if (active_device_name == NULL) {
        return NULL;
    }

    net_info = (NetInfo *) malloc(sizeof(NetInfo));

    fd = socket(AF_INET, SOCK_DGRAM, 0);

    ifr.ifr_addr.sa_family = AF_INET;

    strncpy(ifr.ifr_name, active_device_name, IFNAMSIZ - 1);

    ioctl(fd, SIOCGIFADDR, &ifr);

    close(fd);

    net_info->device_name = active_device_name;
    net_info->ipv4        = inet_ntoa(((struct sockaddr_in *) &ifr.ifr_addr)->sin_addr);
    net_info->type        = net_get_device_type(net_info->device_name);

    return net_info;
}

int main(int argc, char *argv[])
{
    NetInfo *net_info = net_info_get_default();

    if (net_info == NULL) {
        exit(1);
    }

    printf("%s %s\n", net_type_symbol[net_info->type], net_info->ipv4);
}
