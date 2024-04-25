if [ -f ./config.fish ]
    cp -f ./config.fish ~/.config/fish/config.fish
end

if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]
    dpkg -l wslu &> /dev/null || apt-get install -y wslu
end
