"let s:bundles = tr(globpath(&runtimepath, 'bundle/*/'), "\n", ',')
"pathogen stuff 
filetype off
call pathogen#runtime_append_all_bundles() 
call pathogen#helptags()
syntax on
filetype plugin indent on
"let s:afters = tr(globpath(s:bundles, 'after/'), "\n", ',')
"let &runtimepath = join([s:bundles, &runtimepath, s:afters], ',')
"
"Font size
set guifont=Menlo:h11

"turn on autocomplete:
set ofu=syntaxcomplete#Complete
"allows the cursor to wander anywhere it wants
set virtualedit=all

"make php files php/HTML
au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

"makes indenting smart
set autoindent
set smartindent

"adds a bar that tells you where your cursor is
set ruler

"Set color scheme
set t_Co=256
set background=dark
colorscheme solarized

"Highlight current line
se cul

"Hide buffers with changes
set hidden

"Have 3 lines of offset (or buffer) when scrolling
set scrolloff=5

"Hide the toolbar
set guioptions-=T

"turn annoyning beeps into screen flashes
set vb t_vb=

"Search as you type
set incsearch

" Set to auto read when a file is changed from the outside
set autoread

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim_runtime/vimrc

"turn on tab complete menus
set wildmenu 

"Turn on spell checking with English dictionary
set spell
set spelllang=en
set spellsuggest=9 "show only 9 suggestions for misspelled words

"line numbers
set number

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
"make 0 soft bol and ^ a hard bol
noremap 0 ^
noremap ^ 0

"swap h and b
noremap h b
noremap b h
noremap l w
noremap w l

"make - go to the eol and then replace - with _
map - $
map _ -

" Highlight things that we find with the search
set hlsearch

"syntxt on
syntax on

" Unicode support
set encoding=utf-8

" Real tab chars.
set noexpandtab

" Tab spacing.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Use tabs at the start of a line, spaces elsewhere.
set smarttab 

"make vim use an interactive shell
set shell=/bin/bash\ -li

"set mapleader
let mapleader = ","

"Set up keyboard shortcut for bClose
nmap <C-D><C-D> <Plug>Kwbd

"Set up keyboard short cut for quick file finding
nmap <C-F><C-F> :CommandT<CR>

"Set up a quick Last fiLe
nmap <C-L><C-L> :b#<CR>

let g:CommandTMaxHeight = 35
