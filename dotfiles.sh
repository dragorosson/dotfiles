#!/bin/bash -e

scriptdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
linkfiles=$(ls -A $scriptdir/link)
olddir=~/dotfiles_old

if [ -e $olddir ]; then
    echo "$olddir already exists. Safe to remove? (y/n)"
    read shouldremove
    if [ $shouldremove == "y" ]; then
        echo "Removing $olddir"
        rm -rf $olddir
    else
        echo "'y' not entered. Exiting."
        exit 1
    fi
fi

echo "Creating $olddir to backup existing dotfiles in ~"
mkdir -p $olddir

for file in $linkfiles; do
    if [ -e ~/$file ]; then
        echo "Moving ~/$file to $olddir/$file"
        mv ~/$file $olddir
    fi
    echo Symlinking $file
    ln -s $scriptdir/link/$file ~/$file
done
