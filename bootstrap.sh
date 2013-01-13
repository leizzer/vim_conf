#!/bin/sh

# Install vim
sudo apt-get install vim

# Install ctag for project managment
sudo apt-get install exuberant-ctags

# Create ~/.vimrc link to ~/.vim/vimrc
mv ~/.vimrc ~/.vimrc_old
ln -s ~/.vimrc ~/.vim/vimrc
