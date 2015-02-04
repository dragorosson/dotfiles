#!/bin/bash -e

ECHO_BLUE () { echo -e "\033[0;34m${1}\033[0m"; }

ECHO_BLUE "Installing vim dependencies"
sudo apt-get install -y ncurses-dev build-essential

ECHO_BLUE "Downloading vim source"
curl -O http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar jfx vim-7.4.tar.bz2

ECHO_BLUE "Compiling vim"
cd vim74/src
make distclean > /dev/null
./configure --with-features=huge > /dev/null
make > /dev/null
sudo make install > /dev/null
export PATH=/usr/local/bin:$PATH

ECHO_BLUE "Cleaning up"
cd ../..
rm -rf vim74/ vim-7.4.tar.bz2
