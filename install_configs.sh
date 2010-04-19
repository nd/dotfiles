#!/bin/sh
#
# Install all configs
#

# Git:
if test -f ~/.gitconfig
then
    echo "File ~/.gitconfig already exists, move it to ~/.gitconfig-old"
    mv -i ~/.gitconfig ~/.gitconfig-old
fi
ln -s dotfiles/.gitconfig ~/.gitconfig