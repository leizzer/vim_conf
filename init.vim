" ===========================================================================
" ===                          PLUGINS                                    ===
" ===========================================================================
language en_US.UTF8

call plug#begin('~/.local/share/nvim/plugged')


" === Editing Plugins === "
Plug 'ntpeters/vim-better-whitespace' " Trailing whitespace highlighting & automatic fixing
Plug 'rstacruz/vim-closer' " auto-close plugin ( close symbols like [ ] )
Plug 'alvan/vim-closetag' " auto-close plugin for html/jsx tags
Plug 'easymotion/vim-easymotion' " Improved motion in Vim
Plug 'tpope/vim-surround'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" === Highlight ===
Plug 'sheerun/vim-polyglot'

" === Ruby ===
Plug 'tpope/vim-endwise'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tpope/vim-rails'

" === Go ===
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
if exists('g:loaded_polyglot')
    let g:polyglot_disabled = ['go']
endif

" === Icons ===
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" === Misc ===
"" Plug 'racer-rust/vim-racer'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'shougo/echodoc.vim'

" === UI
Plug 'prabirshrestha/vim-lsp'

" === UI
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
"" NOTE: Install LSP


call plug#end()


" ===========================================================================
" ===                          VIM CONFIG                                 ===
" ===========================================================================


" Vim NeoVim direcotry configuration
if has('nvim')
  let s:editor_root=expand("~/.nvim")
else
  let s:editor_root=expand("~/.vim")
endif

set nocompatible                " choose no compatibility with legacy vi
set termguicolors
set t_Co=256                    " Use 256 colours (Use this setting only if your terminal supports 256 colours)
set dir=~/.vim/tmp              " Place swap files in other place for zero directory pollution

" Check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

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

"" Show tabs and trailing spaces (toogle with F11; remove with S-F11)
set listchars=tab:⏤⇢,trail:⇢ 
set list

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" ===========================================================================
" ===                          VIM LSP                                    ===
" ===========================================================================
if executable('standardrb')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'standardrb',
        \ 'cmd': ['standardrb', '--lsp'],
        \ 'allowlist': ['ruby'],
        \ })
endif

" ===========================================================================
" ===                          VIM UI                                     ===
" ===========================================================================


"" Color
set background=dark
colorscheme onedark
" Disable/Enable line numbers
set number
" Always show statusline
set laststatus=2
" Set preview window to appear at bottom
set splitbelow
" Enable mouse
set mouse=a

" === EchoDoc ===
set cmdheight=2 " Needed so ShowMode doesn't override it

" coc.nvim color changes
hi! link CocErrorSign WarningMsg
hi! link CocWarningSign Number
hi! link CocInfoSign Type

" ===========================================================================
" ===                          PLUGIN CONFIG                              ===
" ===========================================================================


" Fugitive vertical gitdiff
set diffopt+=vertical


" === NERDTree === "
" Show hidden files/directories
let g:NERDTreeShowHidden = 1

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" Vim-CloseTag

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>nf - Opens current file location in NERDTree
nmap <leader>nf :NERDTreeFind<CR>
nmap <leader>n :NERDTreeToggle<CR>

" === coc.nvim ===
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gi <Plug>(coc-implementation)

" === vim-better-whitespace === "
"   <leader>sw - Automatically remove trailing whitespace
nmap <leader>sw :StripWhitespace<CR>

map <Leader><Leader> <Plug>(easymotion-prefix)


" ===========================================================================
" ===                          AUTO COMMANDS                              ===
" ===========================================================================


"" Git commit spell check and wrapping
autocmd Filetype gitcommit setlocal spell textwidth=72

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" ===========================================================================
" ===                          TELESCOPE                                  ===
" ===========================================================================

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" ===========================================================================
" ===                          MISC                                       ===
" ===========================================================================


" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" ===========================================================================
" ===                          BACKUP                                     ===
" ===========================================================================
set backupdir=~/.cache/vim/backup//
set directory=~/.cache/vim/swap//
set undodir=~/.cache/vim/undo//
