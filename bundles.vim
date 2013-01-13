set nocompatible

if !isdirectory(expand("~/.vim/bundle/vundle/.git"))
  !git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
endif

filetype off " must be off before Vundle has run

set runtimepath+=~/.vim/bundle/vundle/

call vundle#rc()

Bundle 'https://github.com/kien/ctrlp.vim.git'
