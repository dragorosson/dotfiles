#!/bin/bash -e

ECHO_BLUE () { echo -e "\033[0;34m${1}\033[0m"; }

tmux_file=tmux-2.2

ECHO_BLUE "Installing tmux dependencies"
sudo apt-get install -y ncurses-dev libevent-dev build-essential

ECHO_BLUE "Downloading ${tmux_file} source"
curl -OL https://github.com/tmux/tmux/releases/download/2.2/${tmux_file}.tar.gz
tar zfx ${tmux_file}.tar.gz

ECHO_BLUE "Compiling tmux"
cd ${tmux_file}
ECHO_BLUE "* Configuring..."
./configure > /dev/null
ECHO_BLUE "* Running make..."
make > /dev/null
ECHO_BLUE "* Installing..."
sudo make install > /dev/null

ECHO_BLUE "Cleaning up"
cd ..
rm -rf ${tmux_file} ${tmux_file}.tar.gz
