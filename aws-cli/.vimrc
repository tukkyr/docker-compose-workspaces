set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()
filetype plugin indent on
syntax enable

set background=dark
colorscheme solarized

set st=2 ts=2 sw=2 sts=2
set list
set listchars=tab:>-,trail:$
