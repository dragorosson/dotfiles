#!/bin/bash -e

ECHO_BLUE () { echo -e "\033[0;34m${1}\033[0m"; }

ECHO_BLUE "Installing git"
sudo apt-get update
sudo apt-get install -y git

ECHO_BLUE "Cloning dotfiles"
git clone https://dragorosson@github.com/dragorosson/dotfiles.git

cd dotfiles

if [ $# -eq 1 ] ; then
    ECHO_BLUE "Using branch $1"
    git checkout $1
fi

./linux.sh

ECHO_BLUE "Welcome home."
cd ~
exec zsh
