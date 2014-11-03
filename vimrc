set nocompatible                " choose no compatibility with legacy vi

"" Place swap files in other place for zero directory pollution
set dir=~/.vim/tmp

"" Vundle
silent! runtime bundles.vim

"" Basic Settings
syntax enable
set encoding=utf-8
set laststatus=2                " always show statusbar
set noshowmode                  " hide the default mode text (e.g. --INSERT--)
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
syntax on

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Show tabs and trailing spaces (toogle with F11; remove with S-F11)
set listchars=tab:⏤⇢,trail:⇢ 
set list

"" Color
color darkblue


"""" Config
" use comma as <Leader> key instead of backslash
let mapleader=","

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

map <leader>f :CtrlP<cr>

"" Tags: Create or update
map <leader>tags :! ctags -R --languages=ruby --exclude=.git<cr>

"""" PowerLine
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" " Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
