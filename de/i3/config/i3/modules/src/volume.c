#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <alsa/global.h>
#include <alsa/input.h>
#include <alsa/output.h>
#include <alsa/conf.h>
#include <alsa/pcm.h>
#include <alsa/control.h>
#include <alsa/mixer.h>

//     

typedef enum {
    VOLUME_LEVEL_MUTED,
    VOLUME_LEVEL_OFF,
    VOLUME_LEVEL_LOW,
    VOLUME_LEVEL_HIGH,
    VOLUME_LEVEL_UNKNOWN
} VolumeLevel;

typedef struct {
    long        volume;
    bool        muted;
    VolumeLevel level;
} VolumeInfo;

static const char *volume_level_symbol[] = {
    " ", " ", " ", " ", " "
};

static VolumeLevel volume_info_get_level(VolumeInfo *vol_info)
{
    if (vol_info->muted) {
        return VOLUME_LEVEL_MUTED;
    } else if (vol_info->volume <= 1) {
        return VOLUME_LEVEL_OFF;
    } else if (vol_info->volume < 50) {
        return VOLUME_LEVEL_LOW;
    } else if (vol_info->volume >= 50) {
        return VOLUME_LEVEL_HIGH;
    } else {
        return VOLUME_LEVEL_UNKNOWN;
    }
}

static VolumeInfo *volume_info_get_default(void)
{
    VolumeInfo *vol_info;
    long min, max, vol;
    int mute;
    snd_mixer_t *handle;
    snd_mixer_elem_t* elem;
    snd_mixer_selem_id_t *sid;
    const char *card = "default";
    const char *selem_name = "Master";

    vol_info = (VolumeInfo *) malloc(sizeof(VolumeInfo));

    snd_mixer_open(&handle, 0);
    snd_mixer_attach(handle, card);
    snd_mixer_selem_register(handle, NULL, NULL);
    snd_mixer_load(handle);

    snd_mixer_selem_id_alloca(&sid);
    snd_mixer_selem_id_set_index(sid, 0);
    snd_mixer_selem_id_set_name(sid, selem_name);

    elem = snd_mixer_find_selem(handle, sid);
    snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
    snd_mixer_selem_get_playback_volume(elem, SND_MIXER_SCHN_FRONT_LEFT, &vol);
    snd_mixer_selem_get_playback_switch(elem, 0, &mute);

    snd_mixer_close(handle);

    vol_info->volume = vol * 100/65536;
    vol_info->volume += (vol_info->volume != 0) ? 1 : 0;
    vol_info->muted  = !mute;
    vol_info->level  = volume_info_get_level(vol_info);

    return vol_info;
}

int main(int argc, char *argv[])
{
    VolumeInfo *vol_info = volume_info_get_default();

    printf("%s %d%\n", volume_level_symbol[vol_info->level],
                       vol_info->volume);
}
