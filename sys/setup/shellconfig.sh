#!/bin/sh

if [[ $EUID -eq 0 ]]; then
        echo "You cannot be root."
        exit 1
fi

# Remove existing files if they exist
[[ -f ~/.bashrc                 ]] && sudo rm -f ~/.bashrc
[[ -f /etc/bash.bashrc          ]] && sudo rm -f /etc/bash.bashrc
[[ -f /usr/local/bin/msc        ]] && sudo rm -f /usr/local/bin/msc
[[ -f /usr/local/bin/autoremove ]] && sudo rm -f /usr/local/bin/autoremove
[[ -f /usr/local/bin/mkcfile    ]] && sudo rm -f /usr/local/bin/mkcfile
[[ -f /usr/local/bin/jtk        ]] && sudo rm -f /usr/local/bin/jtk

# Copy files
     install -Dm 0644 bashrc ~/.bashrc
sudo install -Dm 0644 bashrc /etc/bash.bashrc

sudo ln -s ~/Dropbox/Tools/msc                        /usr/local/bin/msc
sudo ln -s ~/Dropbox/Tools/autoremove                 /usr/local/bin/autoremove
sudo ln -s ~/Dropbox/Tools/mkcfile.py                 /usr/local/bin/mkcfile
sudo ln -s ~/Dropbox/Code/Project/git/jtoolkit/jtk.sh /usr/local/bin/jtk

echo "Done"
