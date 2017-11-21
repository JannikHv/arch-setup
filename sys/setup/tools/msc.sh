#!/bin/sh
# [\033[1;32m+\e[0m] - #Green
# [\033[1;34m*\e[0m] - #Blue
# [\033[1;31m-\e[0m] - #Red

alias echo='echo -e'

if [[ $EUID == 0 ]]; then
  echo "[\033[1;31m-\e[0m] You can't be Root."
  exit 1
fi

appd="/usr/share/applications/"
desk="$HOME/Desktop/"

if [[ -z $1 ]]; then
  exit 0
fi

if ! [[ -f $appd$1'.desktop' ]]; then
  echo "[\033[1;31m-\e[0m] Application [\033[1;34m$1\e[0m] does not exist."
  exit 1
elif [[ -f $desk$1'.desktop' ]]; then
  echo "[\033[1;34m*\e[0m] Shortcut [\033[1;34m$1\e[0m] does already exist."
  exit 2
else
  cp        $appd$1'.desktop' $desk$1'.desktop'
  chmod +x  $desk$1'.desktop'
  chmod 777 $desk$1'.desktop'
  exit 0
fi