#!/bin/bash -e

ECHO_BLUE () { echo -e "\033[0;34m${1}\033[0m"; }

scriptdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ECHO_BLUE "Spraying air freshener everywhere"
cd $scriptdir
git pull
./dotfiles.sh
