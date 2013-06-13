#!/bin/sh

# Install vim
sudo apt-get install -y vim

# Install ctag for project managment
sudo apt-get install -y exuberant-ctags

# Bundle install
vim -c BundleInstall! -c q -c q -u bundles.vim

# Create ~/.vimrc link to ~/.vim/vimrc
if [ -f ~/.vimrc ]
then
  mv ~/.vimrc ~/.vimrc_old
fi
ln -s ~/.vim/vimrc ~/.vimrc 

# Create tmp directory for .swp files
mkdir ~/.vim/tmp
