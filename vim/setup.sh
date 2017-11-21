#!/bin/sh

if [[ ${EUID} -eq 0 ]]; then
    echo "You can't be Root'"
    exit 1
fi

# Install vim along plugins
sudo pacman -S vim{,-nerdtree,-runtime} --needed --noconfirm

col_dir="${HOME}/.vim/colors"
syn_dir="/usr/share/vim/vim80/syntax"

mkdir -p "${col_dir}"
sudo mkdir -p "${syn_dir}"

# Refresh colors
rm -f "${col_dir}"/*
cp "colors/"* "${col_dir}"/

# Refresh config
rm -f "${HOME}/.vimrc"
cp config/vimrc "${HOME}/.vimrc"

# Refresh syntax
sudo rm -f "${syn_dir}/c.vim"
sudo cp "syntax/c.vim" "${syn_dir}"/

echo "Done"
