#!/bin/sh

########################################
## Author:  Jannik Hauptvogel
## Email:   JannikHv@gmail.com
## License: GPL2
## Github:  https://github.com/JannikHv
########################################

alias echo="echo -e"

### Functions ###
function show_help() {
        echo "jtoolkit usage:"
        echo "    $ jtk [Option] [...]\n"
        echo "Options:"
        echo "    --link [File] [Dest]    - Link an executable file"
        echo "                              to /usr/local/bin/."
        echo "                              Destination name is not required."
        echo "    --unlink [Filename]     - Unlink an executable file"
        echo "                              from /usr/local/bin/."
        echo "    --encrypt [File] [Dest] - Encrypt a file with aes-256-cbc."
        echo "                              Destination name is not required."
        echo "    --decrypt [File] [Dest] - Decrypt a file with aes-256-cbc."
        echo "    --get-website [URL]     - Download an entire website."
        echo "                              Destination name is not required."
        echo "    --get-aur [Repo]        - Download a package from the AUR."
        echo "    --get-git [User] [Repo] - Clone a repository from Github."
        echo "    --get-mp3 [URL]         - Download a MP3 from Youtube."
        echo "    --get-mp4 [URL]         - Download a MP4 from Youtube."
        echo "    --show [Show Type]      - List different types."
        echo "    --help                  - Show help."
        echo "    --examples              - Show example commands.\n"
        echo "Show Type: (--show)"
        echo "    link                   - Show executables in /usr/local/bin/."
        echo "    autostart              - Show autostarting applications."
}

function show_examples() {
        echo "jtoolkit examples:"
        echo "    # Create /usr/local/bin/script"
        echo "    $ jtk --link my_script.sh script\n"
        echo "    # Create /usr/local/bin/my_script.sh"
        echo "    $ jtk --link my_script.sh\n"
        echo "    # Remove /usr/local/bin/script"
        echo "    $ jtk --unlink script\n"
        echo "    # Encrypt file.txt as file.enc"
        echo "    $ jtk --encrypt file.txt file.enc\n"
        echo "    # Encrypt file.txt as file.txt.enc"
        echo "    $ jtk --encrypt file.txt\n"
        echo "    # Decrypt file.enc as file.txt"
        echo "    $ jtk --decrypt file.enc file.txt\n"
        echo "    # Decrypt file.enc as file"
        echo "    $ jtk --decrypt file.enc\n"
        echo "    $ jtk --get-website https://google.com"
        echo "    $ jtk --get-aur pacaur"
        echo "    $ jtk --get-git jannikhv jtoolkit"
        echo "    $ jtk --get-mp3 [Youtube URL]"
        echo "    $ jtk --get-mp4 [Youtube URL]"
        echo "    $ jtk --show link"
        echo "    $ jtk --show autostart"
}

# Validation of given URL
function jtk_check_url() {
        local url=${1}

        wget --quiet --spider "${url}" &> /dev/null

        if [[ $? -ne 0 ]]; then
                echo "[\033[1;31m-\e[0m] URL not found:"
                echo "    ${url}"

                return 1
        else
                return 0
        fi
}

# --link/--unlink functions
function jtk_link() {
        [[ -z $1 ]] && return 1

        local path_file="$(pwd)/${1}"
        local path_dest
        local name_dest
        local root_flag

        [[ -z $2       ]] && name_dest=${1}   || name_dest=${2}
        [[ $EUID -ne 0 ]] && root_flag="sudo" || root_flag=""

        path_dest="/usr/local/bin/${name_dest}"

        # Check if file to link exists
        if ! [[ -f "${path_file}" ]]; then
                echo "[\033[1;31m-\e[0m] File does not exist:"
                echo "    ${path_file}"
                return 1
        fi

        # Check if executable in /usr/local/bin already exists
        if [[ -f "${path_dest}" ]]; then
                echo "[\033[1;31m-\e[0m] File already exists:"
                echo "    ${path_dest}"
                return 1
        fi

        ${root_flag} ln -s "${path_file}" "${path_dest}"

        if [[ $? -eq 0 ]]; then
                echo "[\033[1;32m+\e[0m] Link created:"
                echo "    ${path_file}"
                echo " -> ${path_dest}"
        fi
}

function jtk_unlink() {
        [[ -z $1 ]] && return 1

        local path_dest="/usr/local/bin/${1}"
        local root_flag

        [[ $EUID -ne 0 ]] && root_flag="sudo" || root_flag=""

        if [[ -f "${path_dest}" ]]; then
                ${root_flag} rm "${path_dest}"
                echo "[\033[1;32m+\e[0m] Link removed:"
                echo "    ${path_dest}"
        else
                echo "[\033[1;31m-\e[0m] File does not exist:"
                echo "    ${path_dest}"
        fi
}

# --encrypt/--decrypt functions
function jtk_encrypt() {
        local name_file=${1}
        local name_dest

        # Check if destination name is given
        [[ -n $2 ]] && name_dest=${2} || name_dest=${1}.enc

        # Check if file to encrypt exists
        if ! [[ -f "${name_file}" ]]; then
                echo "[\033[1;31m-\e[0m] File does not exist:"
                echo "    $(pwd)/${name_file}"
                return 1
        fi

        # Check if destination file already exists
        if [[ -f "${name_dest}" ]]; then
                echo "[\033[1;31m-\e[0m] Destination file already exists:"
                echo "    $(pwd)/${name_dest}"
                return 1
        fi

        openssl enc -aes-256-cbc -in "${name_file}" -out "${name_dest}" &> /dev/null

        if [[ $? -eq 0 ]]; then
                echo "[\033[1;32m+\e[0m] File encrypted:"
                echo "    $(pwd)/${name_file}"
                echo " -> $(pwd)/${name_dest}"
        else
                echo "[\033[1;31m-\e[0m] Failed to encrypt file:"
                echo "    $(pwd)/${name_file}"
        fi
}

function jtk_decrypt() {
        local name_file=${1}
        local name_dest

        # Check if destination name is given
        [[ -n $2 ]] && name_dest=${2} || name_dest=${1::-4}

        # Check if file to encrypt exists
        if ! [[ -f "${name_file}" ]]; then
                echo "[\033[1;31m-\e[0m] File does not exist:"
                echo "    $(pwd)/${name_file}"
                return 1
        fi

        # Check if destination file already exists
        if [[ -f "${name_dest}" ]]; then
                echo "[\033[1;31m-\e[0m] Destination file already exists:"
                echo "    $(pwd)/${name_dest}"
                return 1
        fi

        openssl enc -aes-256-cbc -d -in "${name_file}" -out "${name_dest}" &> /dev/null

        if [[ $? -eq 0 ]]; then
                echo "[\033[1;32m+\e[0m] File decrypted:"
                echo "    $(pwd)/${name_file}"
                echo " -> $(pwd)/${name_dest}"
        else
                rm "${name_dest}"
                echo "[\033[1;31m-\e[0m] Failed to decrypt file:"
                echo "    $(pwd)/${name_file}"
        fi
}

# --get-* functions
function jtk_get_website() {
    local url=${1}

    jtk_check_url "${url}" || return 1

    wget -mkEpnp "${url}"
}

function jtk_get_aur() {
        local pkg_name=${1}
        local url_pkg="https://aur.archlinux.org/packages/${pkg_name}"
        local url_git="https://aur.archlinux.org/${pkg_name}.git"

        jtk_check_url "${url_pkg}" || return 1

        git clone "${url_git}"
}

function jtk_get_git() {
        local pkg_user=${1}
        local pkg_name=${2}
        local url_pkg="https://github.com/${pkg_user}/${pkg_name}"
        local url_git="https://github.com/${pkg_user}/${pkg_name}.git"

        jtk_check_url "${url_pkg}" || return 1

        git clone "${url_git}"
}

function jtk_get_mp3() { 
        local url=${1}

        jtk_check_url "${url}" || return 1

        youtube-dl -x --audio-format "mp3" --audio-quality 0 "${url}" --no-playlist
}

function jtk_get_mp4() {
        local url=${1}

        jtk_check_url "${url}" || return 1

        youtube-dl -f "mp4" "${url}" --no-playlist
}

# --show functions
function jtk_show_link() {
        echo "[\033[1;34m*\e[0m] Links:"
        for i in $(ls /usr/local/bin/); do
                echo "    ${i}"
        done
}

function jtk_show_autostart() {
        echo "[\033[1;34m*\e[0m] Autostart:"
        for i in $(ls ~/.config/autostart/); do
                echo "    ${i}"
        done
}

# Evaluate arguments
for arg in ${@}; do
        case ${1} in
                --link)         jtk_link "${2}" "${3}"
                                shift
                                ;;
                --unlink)       jtk_unlink "${2}"
                                shift
                                ;;
                --encrypt)      jtk_encrypt "${2}" "${3}"
                                shift
                                ;;
                --decrypt)      jtk_decrypt "${2}" "${3}"
                                shift
                                ;;
                --get-website)  jtk_get_website "${2}"
                                shift
                                ;;
                --get-aur)      jtk_get_aur "${2}"
                                shift
                                ;;
                --get-git)      jtk_get_git "${2}" "${3}"
                                shift
                                ;;
                --get-mp3)      jtk_get_mp3 "${2}"
                                shift
                                ;;
                --get-mp4)      jtk_get_mp4 "${2}"
                                shift
                                ;;
                --show)         case ${2} in
                                        link)           jtk_show_link
                                                        ;;
                                        autostart)      jtk_show_autostart
                                                        ;;
                                                *)      ;;
                                esac
                                shift
                                ;;
                --help)         show_help
                                exit 0
                                ;;
                --examples)     show_examples
                                exit 0
                                ;;
                         *)     shift
                                ;;
        esac
done
