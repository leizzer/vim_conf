set nocompatible

" required for vundle
filetype off

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

"" Bundle list
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'matchit.zip'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'kchmck/vim-coffee-script'
Bundle 'slim-template/vim-slim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdtree'

filetype plugin indent on     " required!

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

