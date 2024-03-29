set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'

Plug 'mattn/emmet-vim'

Plug 'mileszs/ack.vim'

Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-repeat'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'jacoborus/tender.vim'
Plug 'fatih/vim-go'

Plug 'fatih/molokai'

Plug 'jparise/vim-graphql'

call plug#end()
filetype plugin indent on
syntax enable

set nrformats=
set encoding=utf-8
set nowrap
set foldmethod=indent
set foldlevel=5

autocmd BufRead * normal zR

let g:molokai_original = 1
" silent! colorscheme tender
silent! colorscheme molokai
hi Comment guifg=#A1A1A1
hi FoldColumn guifg=#B1B1B1
hi Folded guifg=#B1B1B1

let g:airline_theme='jellybeans'
" let g:airline_theme='tender'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#clock#auto = 1

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! LineNr ctermbg=NONE guibg=NONE

hi clear SpellBad
hi SpellBad cterm=underline

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>

" set hls
set number
set spelllang+=cjk
set spell
set autowrite

" set ts=4 sw=4 noet
set ts=2 sw=2 sts=2 et

set list
set listchars=tab:>-,trail:$
set termguicolors
set pumblend=40
set winblend=20

set backspace=indent,eol,start

" let g:EasyMotion_do_mapping=0

nnoremap <leader>c :cclose<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.md setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

autocmd QuickFixCmdPost *grep* cwindow

let g:ctrlp_custom_ignore = 'node_modules'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" command! -nargs=0 Format :call CocActionAsync('format')

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
" autocmd BufWritePre *.go :Format

nnoremap <silent> <C-k> :call <SID>show_documentation()<CR>
nmap <leader>rn <Plug>(coc-rename)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:go_list_type = 'quickfix'
let g:go_gopls_enabled = 0
let g:go_info_mode='gopls'
let g:go_def_mode='gopls'
let g:go_def_mapping_enabled = 0
let g:go_fmt_autosave = 0
let g:go_mod_fmt_autosave = 0
let g:go_template_autocreate = 0
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

autocmd FileType vue syntax sync fromstart

imap <C-l> <Plug>(coc-snippets-expand)
" let g:coc_snippet_next = '<c-j>'
" let g:coc_snippet_prev = '<c-k>'

nmap s <Plug>(easymotion-overwin-f)

set undofile

if !isdirectory(expand("$HOME/.vim/undodir"))
  call mkdir(expand("$HOME/.vim/undodir"), "p")
endif

set undodir=$HOME/.vim/undodir

set wildmenu

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

set sh=bash
tnoremap <silent> <ESC> <C-\><C-n>

" noremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" let g:coc_snippet_next = '<tab>'
