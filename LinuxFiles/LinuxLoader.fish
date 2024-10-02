# Install the fish config file
if [ -f ./config.fish ]
    cp -f ./config.fish ~/.config/fish/config.fish
end

# If in wsl install some helpful stuff
if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]
    dpkg -l wslu &> /dev/null || apt-get install -y wslu
end

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
