#!/bin/sh

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
