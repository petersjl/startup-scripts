#!/bin/sh

#make sure apt-get is installed
command -v apt-get > /dev/null || { echo "apt-get is required to run this script."; exit 1; }

sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt update
sudo apt install -y fish
chsh -s /usr/bin/fish

if test -f ./LinuxLoader.fish; then
    fish ./LinuxLoader.fish
    exec fish
else
    echo "Missing file 'LinuxLoader.fish'"
    exit 1
fi
