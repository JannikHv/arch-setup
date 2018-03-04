#!/bin/sh

if [[ $EUID -eq 0 ]]; then
        echo "You cannot be root."
        exit 1
fi

bin_dir="/usr/local/bin"

sudo rm -f "${bin_dir}/"{msc,autoremove,mkcfile,jtk,sasswatch}
sudo rm -f "/etc/bash.bashrc" "${HOME}/.bashrc"

sudo ln -s "$(pwd)/tools/msc.sh"        "${bin_dir}/msc"
sudo ln -s "$(pwd)/tools/autoremove.sh" "${bin_dir}/autoremove"
sudo ln -s "$(pwd)/tools/mkcfile.py"    "${bin_dir}/mkcfile"
sudo ln -s "$(pwd)/tools/jtk.sh"        "${bin_dir}/jtk"
sudo ln -s "$(pwd)/tools/sasswatch.sh"  "${bin_dir}/sasswatch"

cp "config/bashrc" "${HOME}/.bashrc"
sudo cp "config/bashrc" "/etc/bash.bashrc"

echo "Done"
