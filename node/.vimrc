set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'mattn/emmet-vim'
Plug 'fatih/molokai'
Plug 'tpope/vim-surround'
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'ryanolsonx/vim-lsp-javascript'

call plug#end()
filetype plugin indent on
syntax enable

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['eslint'],
\  'vue': ['eslint'],
\}
let g:ale_fix_on_save = 1

set background=dark
set st=2 ts=2 sw=2 sts=2 et
set list
let g:molokai_original = 1
silent! colorscheme molokai
hi Comment guifg=#A1A1A1 ctermfg=gray
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue EmmetInstall
runtime macros/matchit.vim
let b:match_words = 'if:endif,foreach:endforeach,\<begin\>:\<end\>'
set listchars=tab:>-,trail:$

let g:javascript_plugin_jsdoc = 1

set foldlevel=2
set foldmethod=indent

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    " setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <C-]> <plug>(lsp-definition)
    nmap <buffer> <f2> <plug>(lsp-rename)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_fold_enabled = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_signs_enabled = 0

if executable('vls')
  augroup LspVls
    au User lsp_setup call lsp#register_server({
        \ 'name': 'vue-language-server',
        \ 'cmd': {server_info->['vls']},
        \ 'whitelist': ['vue'],
        \ 'initialization_options': {
        \         'config': {
        \             'html': {},
        \              'vetur': {
        \                  'validation': {}
        \              }
        \         }
        \     }
        \ })
  augroup end
endif
