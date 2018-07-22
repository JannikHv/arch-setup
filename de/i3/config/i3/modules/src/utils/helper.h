#ifndef __HELPER_H__
#define __HELPER_H__

#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <stdbool.h>
#include <unistd.h>

#define CHUNK_SIZE 512

static inline bool file_exists_from_path(const char *path)
{
    return (access(path, F_OK) == -1) ? false : true;
}

static inline bool dir_exists_from_path(const char *path)
{
    DIR *dir = opendir(path);

    if (dir != NULL) {
        closedir(dir);
        return true;
    } else {
        return false;
    }
}

static inline const char *read_file_from_path(const char *path)
{
    FILE *file    = fopen(path, "r");
    char *content = (char *) malloc(sizeof(char) * CHUNK_SIZE);

    if (file == NULL) {
        free(content);
        return NULL;
    }

    if (content == NULL) {
        fclose(file);
        return NULL;
    }

    fgets(content, CHUNK_SIZE, file);
    fclose(file);
    content[strcspn(content, "\n")] = '\0';

    return content;
}

static inline int get_process_count_by_name(const char *p_name)
{
    int count = 0;
    const char *content;
    char tmp_path[CHUNK_SIZE];
    DIR *dir = opendir("/proc");
    struct dirent *ent;

    if (dir == NULL) {
        return 0;
    }

    while ((ent = readdir(dir)) != NULL) {
        sprintf(tmp_path, "%s%s%s", "/proc/", ent->d_name, "/comm");

        if (file_exists_from_path(tmp_path)) {
            content = read_file_from_path(tmp_path);

            if (strcmp(content, p_name) == 0) {
                count++;
            }
        }
    }

    return count;
}

#endif /* __HELPER_H__ */
