#!/bin/sh
#
# Install zsh configs
#

cd $HOME;
if test -f .zshrc
then
    echo "File ~/.zshrc already exists, move it to ~/.zshrc-old"
    mv -i .zshrc .zshrc-old
fi
ln -s dotfiles/zsh/.zshrc 