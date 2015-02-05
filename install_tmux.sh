#!/bin/bash -e

ECHO_BLUE () { echo -e "\033[0;34m${1}\033[0m"; }

ECHO_BLUE "Installing tmux dependencies"
sudo apt-get install -y ncurses-dev libevent-dev build-essential

ECHO_BLUE "Downloading tmux 1.9a source"
curl -OL http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz
tar zfx tmux-1.9a.tar.gz

ECHO_BLUE "Compiling tmux"
cd tmux-1.9a
ECHO_BLUE "* Configuring..."
./configure > /dev/null
ECHO_BLUE "* Running make..."
make > /dev/null
ECHO_BLUE "* Installing..."
sudo make install > /dev/null

ECHO_BLUE "Cleaning up"
cd ..
rm -rf tmux-1.9a tmux-1.9a.tar.gz
