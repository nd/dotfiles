#!/bin/sh

cd; #in home dir
if [ -f .zshrc] 
then
    echo "File ~/.zshrc already exists, move it to ~/.zshrc-old"
    mv .zshrc .zshrc-old
fi
ln -s dotfiles/zsh/.zshrc 