#!/bin/bash -e

ECHO_BLUE () { echo -e "\033[0;34m${1}\033[0m"; }

ECHO_BLUE "Installing git"
sudo apt-get update
sudo apt-get install -y git

ECHO_BLUE "Cloning dotfiles"
git clone https://github.com/dragorosson/dotfiles.git

cd dotfiles
./linux.sh

ECHO_BLUE "Welcome home."
