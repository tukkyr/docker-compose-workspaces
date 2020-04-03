FROM node:buster

RUN apt-get update && apt-get install -y isomd5sum python3 python3-pip python3-venv git vim curl jq gettext groff && rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/apt/cache/*

RUN curl -o ${HOME}/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh \
 && mkdir -p ${HOME}/.vim/autoload && curl -o ${HOME}/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN echo "HISTFILE=/history/.bash_history \n\
export TZ=Asia/Tokyo" | tee -a ${HOME}/.bashrc

RUN echo "alias vi=\"vim\"\n\
HISTFILE=/history/.bash_history\n\
HISTSIZE=50000\n\
HISTFILESIZE=50000\n\
HISTCONTROL=ignoreboth\n\
HISTTIMEFORMAT='%FT%T%z '\n\
HISTIGNORE='ls*:exit*:history*:cd\ -:cd:cd\ \.\.'\n\
export TZ=Asia/Tokyo\n\
export LANG=C.UTF-8\n\
export LANGUAGE=en_US:\n\
alias ls=\"ls --color\"\n\
. ${HOME}/.git-prompt.sh\n\
GIT_PS1_SHOWDIRTYSTATE=1\n\
GIT_PS1_SHOWUPSTREAM=1\n\
GIT_PS1_SHOWUNTRACKEDFILES=1\n\
GIT_PS1_SHOWSTASHSTATE=1\n\
PS1='\[\e[33m\]\D{%H:%M:%S}\[\e[m\] \[\e[36m\]\h:\W\[\e[m\] \[\e[1;32m\]\$(__git_ps1 \"< %s > \")\[\e[m\]\$ '" | tee -a ${HOME}/.bashrc

RUN npm install -g typescript \
 && npm install -g @vue/cli \
 && npm install -g typescript-language-server vls

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

COPY .vimrc /root

ARG username
ARG email

RUN set -u \
 && git config --global credential.helper cache \
 && git config --global user.name ${username} \
 && git config --global user.email ${email}

WORKDIR /root/environment

CMD ["sh", "-c", "while sleep 3600; do :; done"]
