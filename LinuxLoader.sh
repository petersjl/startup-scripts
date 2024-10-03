#!/bin/sh

SCRIPT_LOCATION="./LinuxFiles/Scripts"

#make sure apt-get is installed
command -v apt-get > /dev/null || { echo "apt-get is required to run this script."; exit 1; }

if ! command -v fish > /dev/null; then
    sudo apt-add-repository -y ppa:fish-shell/release-3
    sudo apt update 
fi

# Install all the commands from apt
sudo apt install -y fish neovim zip build-essentials

# Set fish and neovim as the defaults
chsh -s /usr/bin/fish
echo "SELECTED_EDITOR=\"$(which nvim)\"" > ~/.selected_editor

if test -f ./LinuxFiles/LinuxLoader.fish; then
    fish ./LinuxFiles/LinuxLoader.fish
else
    echo "Missing file './LinuxFiles/LinuxLoader.fish'"
fi

NVIM_CONF="./LinuxFiles/config/nvim"
if test -d $NVIM_CONF; then
	cp -r $NVIM_CONF "~/.config/"
else
	echo "Missing neovim config files"
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

exec fish
