#ifndef __HELPER_H__
#define __HELPER_H__

#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <stdbool.h>
#include <unistd.h>

#define CHUNK_SIZE 512

static inline const char *read_from_command(const char *command)
{
    FILE *process;
    char *content;

    process = popen(command, "r");
    content = (char *) malloc(sizeof(char) * CHUNK_SIZE);

    if (process == NULL) {
        return NULL;
    }

    if (content == NULL) {
        fclose(process);
        return NULL;
    }

    fgets(content, CHUNK_SIZE, process);
    fclose(process);
    content[strcspn(content, "\n")] = '\0';

    return content;
}

static inline const char *read_file_from_path(const char *path)
{
    FILE *file;
    char *content;

    file    = fopen(path, "r");
    content = (char *) malloc(sizeof(char) * CHUNK_SIZE);

    if (file == NULL) {
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

static inline bool file_exists(const char *path)
{
    return (access(path, F_OK) == -1) ? false : true;
}

static inline bool dir_exists(const char *path)
{
    DIR *dir;

    dir = opendir(path);

    if (dir != NULL) {
        closedir(dir);
        return true;
    } else {
        return false;
    }
}

#endif /* __HELPER_H__ */
