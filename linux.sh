#!/bin/bash -e

ECHO_BLUE () { echo -e "\033[0;34m${1}\033[0m"; }

ECHO_BLUE "Uninstalling vim-tiny"
sudo apt-get remove -y vim-tiny

ECHO_BLUE "Installing vim, tmux, and zsh"
sudo apt-get install -y vim tmux zsh

ECHO_BLUE "Installing oh-my-zsh"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

ECHO_BLUE "Rearranging furniture"
./dotfiles.sh

