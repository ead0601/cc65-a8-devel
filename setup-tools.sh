#!/bin/bash

# Ideal structure
# 
# <repo dir>
#    <tools dir>
#    <cc65-a8-devel>
#    <other-repo>
#    .. (other git hub repos)

echo " "
echo "Creating tools dir..."
echo " "
sleep 2

# Make tools dir
#
cd ..
if [-d ./tools ]; then
    cd tools
else
    mkdir tools
    cd tools
fi

echo " "
echo "Github clone of cc65..."
echo " "
sleep 2

# Get CC65
#
git clone https://github.com/cc65/cc65

# Compile it
# 
cd cc65
make

echo " "
echo "Apt install of atari800..."
echo " "
sleep 2
sudo apt install atari800

echo " "
echo "Done..."
echo " "
echo "Update your .bashrc to add the following system variables:"
echo " "
echo 'export CC65_HOME="...path to your repo/tools/cc65'
echo 'export A8_EMULATOR="/usr/bin/atari800"'
echo " "

exit








