#!/bin/sh

SCRIPT_LOCATION="./LinuxFiles/Scripts"

#make sure apt-get is installed
command -v apt-get > /dev/null || { echo "apt-get is required to run this script."; exit 1; }

if ! command -v fish > /dev/null; then
    sudo apt-add-repository -y ppa:fish-shell/release-3
    sudo apt update
    sudo apt install -y fish
fi
chsh -s /usr/bin/fish

if test -f ./LinuxFiles/LinuxLoader.fish; then
    fish ./LinuxFiles/LinuxLoader.fish
    exec fish
else
    echo "Missing file './LinuxFiles/LinuxLoader.fish'"
    exit 1
fi

if test -d $SCRIPT_LOCATION; then
    if ! test -d ~/bin; then
        mkdir ~/bin
    fi

    readarray -t files <<< $(ls $SCRIPT_LOCATION)
    for file in "${files[@]}"; do
        cp "$SCRIPT_LOCATION/$file" ~/bin/
    done
fi