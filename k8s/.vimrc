set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-surround'
Plug 'fatih/molokai'

call plug#end()
filetype plugin indent on
syntax enable

let g:molokai_original = 1
silent! colorscheme molokai

set number
set spelllang+=cjk
set spell
set autowrite

set list
set listchars=tab:>-,trail:$

set st=2 sts=2 ts=2 sw=2 et


