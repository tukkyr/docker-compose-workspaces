set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'easymotion/vim-easymotion'
Plug 'jacoborus/tender.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'enricobacis/vim-airline-clock'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'fatih/vim-go'
Plug 'fatih/molokai'
Plug 'cohama/lexima.vim'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()
filetype plugin indent on
syntax enable

set nrformats=
set encoding=utf-8
set nowrap

if (has("termguicolors"))
  set termguicolors
 silent! colorscheme tender
 let g:airline_theme='tenderplus'
endif
if &term == "screen"
 set t_Co=256
 if (has("termguicolors"))
   set notermguicolors
 endif
endif

let g:molokai_original = 1
silent! colorscheme molokai

" let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#clock#auto = 1

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! LineNr ctermbg=NONE guibg=NONE

hi clear SpellBad
hi SpellBad cterm=underline

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" set hls
set number
set spelllang+=cjk
set spell
set autowrite

" set ts=4 sw=4 noet
set ts=2 sw=2 sts=2 et

set list
set listchars=tab:>-,trail:$

set backspace=indent,eol,start

let g:EasyMotion_do_mapping = 0

nmap s <Plug>(easymotion-overwin-f2)

nnoremap <leader>a :cclose<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>
imap <C-j> <C-x><C-o>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
 if l:file =~# '^\f\+_test\.go$'
   call go#test#Test(0, 1)
 elseif l:file =~# '^\f\+\.go$'
   call go#cmd#Build(0)
 endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>k <Plug>(go-doc)
autocmd FileType go nmap <Leader>d <Plug>(go-describe)
autocmd Filetype go nmap <Leader>i <Plug>(go-implements)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.md setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

let g:go_auto_type_info = 1
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_code_completion_enabled = 1
let g:go_def_mapping_enabled = 1
let g:go_def_keywordprg_enable = 0
let g:go_template_autocreate = 0
let g:go_auto_sameids = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_rename_command='gopls'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave = 1

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

set updatetime=300
