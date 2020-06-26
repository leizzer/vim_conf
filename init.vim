" ===========================================================================
" ===                          PLUGINS                                    ===
" ===========================================================================


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

" === Rust ===
"" Plug 'rust-lang/rust.vim' " not sure if needed with polyglot

" === Icons ===
Plug 'ryanoasis/vim-devicons'
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

" === Denite ===
Plug 'shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" <<< Denite

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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

try
  autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> <c-t>
                \ denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> <c-v>
                \ denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> <c-x>
                \ denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> V
                \ denite#do_map('toggle_select').'j'
endfunction


autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <tab> <Plug>(denite_filter_quit)
    inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    inoremap <silent><buffer><expr> <c-t>
                \ denite#do_map('do_action', 'tabopen')
    inoremap <silent><buffer><expr> <c-v>
                \ denite#do_map('do_action', 'vsplit')
    inoremap <silent><buffer><expr> <c-x>
                \ denite#do_map('do_action', 'split')
    inoremap <silent><buffer><expr> <esc>
                \ denite#do_map('quit')
    inoremap <silent><buffer> <C-j>
                \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <C-k>
                \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction


" Change matchers.
call denite#custom#source(
\ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])

call denite#custom#source('tag', 'matchers', ['matcher/substring'])

call denite#custom#source('file/old', 'converters',
      \ ['converter/relative_word'])
" Change sorters.
call denite#custom#source(
\ 'file/rec', 'sorters', ['sorter/sublime'])


" Ag command on grep source
if executable('ag')
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('file/rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

if executable('ack')
    " Ack command on grep source
    call denite#custom#var('grep', 'command', ['ack'])
    call denite#custom#var('grep', 'default_opts',
                \ ['--ackrc', $HOME.'/.ackrc', '-H', '-i',
                \  '--nopager', '--nocolor', '--nogroup', '--column'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--match'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
endif

if executable('rg')
    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    " For ripgrep
    " Note: It is slower than ag
    call denite#custom#var('file/rec', 'command',
                \ ['rg', '--files', '--glob', '!.git'])
endif


if executable('pt')
    " Pt command on grep source
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    " For Pt(the platinum searcher)
    " NOTE: It also supports windows.
    call denite#custom#var('file/rec', 'command',
                \ ['pt', '--follow', '--nocolor', '--nogroup',
                \  (has('win32') ? '-g:' : '-g='), ''])
endif

" Define alias
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#alias('source', 'file/rec/py', 'file/rec')
call denite#custom#var('file/rec/py', 'command',['scantree.py'])

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

let s:denite_options = {
      \ 'prompt' : '>',
      \ 'split': 'floating',
      \ 'start_filter': 1,
      \ 'auto_resize': 1,
      \ 'source_names': 'short',
      \ 'direction': 'botright',
      \ 'highlight_filter_background': 'CursorLine',
      \ 'highlight_matched_char': 'Type',
      \ }

call denite#custom#option('default', s:denite_options)

catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

try
  " === Vim airline ==== "
  " Enable extensions
  let g:airline_extensions = ['branch', 'hunks', 'coc']

  " Update section z to just have line number
  let g:airline_section_z = airline#section#create(['linenr'])

  " Do not draw separators for empty sections (only for the active window) >
  let g:airline_skip_empty_sections = 1

  " Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
  let g:airline#extensions#tabline#formatter = 'unique_tail'

  " Custom setup that removes filetype/whitespace from default vim airline bar
  let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

  let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

  let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

  " Configure error/warning section to use coc.nvim
  let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
  let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

  " Hide the Nerdtree status line to avoid clutter
  let g:NERDTreeStatusline = ''

  " Disable vim-airline in preview mode
  let g:airline_exclude_preview = 1

  " Enable powerline fonts
  let g:airline_powerline_fonts = 1

  " Enable caching of syntax highlighting groups
  let g:airline_highlighting_cache = 1

  " Define custom airline symbols
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = '❯'
  let g:airline_right_sep = '❮'

  " Don't show git changes to current file in airline
  let g:airline#extensions#hunks#enabled=0

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry


" ===========================================================================
" ===                          KEY MAPS                                   ===
" ===========================================================================


"""" Config
" use comma as <Leader> key instead of backslash
let mapleader="\\"

"" Terminal Inside vim terminal
map <F2> :terminal
map <F3> <C-\><C-n>

"" Change tab with page up and down
nmap <C-PageUp> :bp<CR>
nmap <C-PageDown> :bn<CR>

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>d - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and
"   close window if no results
"   <leader># - Search current directory for occurences of word under cursor
nmap , :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>d :DeniteProjectDir file/rec -split=floating -winrow=1<CR>
nnoremap <leader>g :<C-u>DeniteProjectDir grep:. -no-empty -mode=normal<CR>
nnoremap <leader># :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

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
" ===                          MISC                                       ===
" ===========================================================================


" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif
