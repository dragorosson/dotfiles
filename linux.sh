#!/bin/bash -e

ECHO_BLUE () { echo -e "\033[0;34m${1}\033[0m"; }

ECHO_BLUE "Installing tmux and zsh"
sudo apt-get install -y tmux zsh

ECHO_BLUE "Linking dotfiles"
./dotfiles.sh

