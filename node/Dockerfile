FROM node:buster

RUN apt-get update && apt-get install -y isomd5sum python3 python3-pip python3-venv git vim curl jq gettext groff && rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/apt/cache/*

RUN curl -o ${HOME}/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh \
 && mkdir -p ${HOME}/.vim/autoload && curl -o ${HOME}/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN echo "HISTFILE=/history/.bash_history \n\
HISTSIZE=50000\n\
HISTFILESIZE=50000\n\
HISTCONTROL=ignoreboth\n\
HISTTIMEFORMAT='%FT%T%z '\n\
HISTIGNORE='ls*:exit*:history*:cd\ -:cd:cd\ \.\.'" | tee -a ${HOME}/.bashrc

RUN echo "alias vi=\"vim\"\n\
alias ls=\"ls --color\"\n\
. ${HOME}/.git-prompt.sh\n\
GIT_PS1_SHOWDIRTYSTATE=1\n\
GIT_PS1_SHOWUPSTREAM=1\n\
GIT_PS1_SHOWUNTRACKEDFILES=1\n\
GIT_PS1_SHOWSTASHSTATE=1\n\
PS1='\[\e[33m\]\D{%H:%M:%S}\[\e[m\] \[\e[36m\]\h:\W\[\e[m\] \[\e[1;32m\]\$(__git_ps1 \"< %s > \")\[\e[m\]\$ '" | tee -a ${HOME}/.bashrc

RUN npm install -g typescript \
 && npm install -g @vue/cli

RUN apt-get update \
 && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
 && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
 && apt-key fingerprint 0EBFCD88 \
 &&  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" \
 && apt-get update \
 && apt-get install -y docker-ce docker-ce-cli containerd.io \
 # && usermod -aG docker your-user \
 && rm -rf /var/lib/apt/cache/*


RUN echo "set nocompatible\n\
filetype off\n\n\
call plug#begin('~/.vim/plugged')\n\n\
Plug 'VundleVim/Vundle.vim'\n\
Plug 'mattn/emmet-vim'\n\
Plug 'fatih/molokai'\n\
Plug 'tpope/vim-surround'\n\
Plug 'posva/vim-vue'\n\
Plug 'leafgarland/typescript-vim'\n\n\
call plug#end()\n\
filetype plugin indent on\n\
syntax enable\n\n\
set background=dark\n\
set st=2 ts=2 sw=2 sts=2 noet\n\
set list \n\
let g:molokai_original = 1\n\
silent! colorscheme molokai\n\
hi Comment guifg=#A1A1A1 \n\
let g:user_emmet_install_global = 0\n\
autocmd FileType html,css,vue EmmetInstall\n\
runtime macros/matchit.vim\n\
let b:match_words = "if:endif,foreach:endforeach,\<begin\>:\<end\>"\n\
set listchars=tab:>-,trail:$" | tee -a ${HOME}/.vimrc

RUN vim +PlugInstall +qall

WORKDIR /root/environment

CMD ["sh", "-c", "while sleep 3600; do :; done"]
