" PLUGINS
" autopairs: https://github.com/jiangmiao/auto-pairs/
" ctrlp: https://github.com/kien/ctrlp.vim

set nocompatible
execute pathogen#infect()
set ruler laststatus=2 relativenumber title hlsearch incsearch
syntax on
colorscheme molokai
let g:molokai_original = 1 " Enables original monokai background colour

set title " Change terminal's title

set hidden " Hides buffers instead of closing them
:set guioptions-=T " Remove toolbar
:set guioptions-=m " Remove menu bar
:set guioptions-=M " Remove menu bar
:set guioptions-=r " Remove right-hand scroll bar
:set guioptions-=L " Remove left-hand scrollbar
set shortmess+=I

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set showmatch " Show matching parethesis

" Disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

set mouse=""
inoremap jk <ESC>

nnoremap <F5> :GundoToggle<CR>

let mapleader=","
filetype plugin indent on
set encoding=utf-8
