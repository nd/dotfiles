#!/bin/sh

cd; #in home dir
if test -f .zshrc 
then
    echo "File ~/.zshrc already exists, copy it to ~/.zshrc-old"
    cp .zshrc .zshrc-old
fi
ln -s dotfiles/zsh/.zshrc 