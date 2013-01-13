#!/bin/sh

# Install vim
sudo apt-get install vim

# Install ctag for project managment
sudo apt-get install exuberant-ctags

# Bundle install
vim -c BundleInstall! -c q -c q -u bundles.vim

# Create ~/.vimrc link to ~/.vim/vimrc
mv ~/.vimrc ~/.vimrc_old
ln -s ~/.vim/vimrc ~/.vimrc 
