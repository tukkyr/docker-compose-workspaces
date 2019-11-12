FROM python:buster

RUN apt-get update && apt-get install -y isomd5sum git vim curl jq gettext groff && rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/apt/cache/*

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

RUN echo "set nocompatible\n\
filetype off\n\n\
call plug#begin('~/.vim/plugged')\n\n\
Plug 'VundleVim/Vundle.vim'\n\n\
call plug#end()\n\
filetype plugin indent on\n\
syntax enable \n\n\
set st=4 ts=4 sw=4" | tee -a ${HOME}/.vimrc

RUN set -x \
 && curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest \
 && echo "$(curl -s https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest.md5) /usr/local/bin/ecs-cli" | md5sum -c - \
 && chmod +x /usr/local/bin/ecs-cli

RUN pip install -U pip setuptools wheel && pip install -U awscli \
 && echo "complete -C aws_completer aws" | tee -a ${HOME}/.bashrc

RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" \
 && dpkg -i session-manager-plugin.deb \
 && rm session-manager-plugin.deb

WORKDIR /root/environment

CMD ["sh", "-c", "while sleep 3600; do :; done"]
