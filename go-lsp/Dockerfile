FROM golang:1.14-buster

RUN apt-get update && apt-get install --no-install-recommends -y lsb-release tree vim jq ssh-client unzip graphviz rsync && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ${HOME}/.git-prompt.sh \
 # && echo 'test -r ~/.bashrc && . ~/.bashrc' >> ${HOME}/.bash_profile \
 && HISTSIZE=50000 \
 && HISTFILESIZE=50000 \
 && HISTCONTROL=ignoreboth \
 && HISTTIMEFORMAT='%FT%T%z ' \
 && HISTIGNORE='ls*:exit*:history*:cd\ -:cd:cd\ \.\.' \
 && echo 'export TZ="Asia/Tokyo"' >> ${HOME}/.bashrc \
 && echo 'stty stop undef' >> ${HOME}/.bashrc \
 && echo 'alias vi="vim"' >> ${HOME}/.bashrc \
 && echo 'alias ls="ls --color"' >> ${HOME}/.bashrc \
 && echo . ${HOME}/.git-prompt.sh >> ${HOME}/.bashrc \
 && echo GIT_PS1_SHOWDIRTYSTATE=1 >> ${HOME}/.bashrc \
 && echo GIT_PS1_SHOWUPSTREAM=1 >> ${HOME}/.bashrc \
 && echo GIT_PS1_SHOWUNTRACKEDFILES=1 >> ${HOME}/.bashrc \
 && echo GIT_PS1_SHOWSTASHSTATE=1  >> ${HOME}/.bashrc \
 && echo "PS1='\[\e[33m\]\D{%H:%M:%S}\[\e[m\] \[\e[36m\]\h:\W\[\e[m\] \[\e[1;32m\]\$(__git_ps1 \"< %s > \")\[\e[m\]\$ '" >> ${HOME}/.bashrc

COPY .vimrc /root

RUN curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
 && vim -c PlugInstall -c q -c q \
 && vim -c GoInstallBinaries -c q

WORKDIR /tmp

RUN go get -u google.golang.org/grpc \
 && go get -u github.com/golang/protobuf/protoc-gen-go \
 && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
 && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger \
 && wget https://github.com/protocolbuffers/protobuf/releases/download/v3.10.1/protoc-3.10.1-linux-x86_64.zip \
 && mkdir build \
 && unzip protoc-3.10.1-linux-x86_64.zip -d build \
 && mv build/include/* /usr/local/include/ \
 && mv build/bin/protoc /usr/local/bin \
 && rm -rf protoc-3.10.1-linux-x86_64.zip build

RUN go get -u golang.org/x/tools/cmd/godoc \
 && go get -u github.com/kisielk/errcheck

ARG username
ARG email

RUN set -u \
 && git config --global credential.helper cache \
 && git config --global user.name ${username} \
 && git config --global user.email ${email}

RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"\
 && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -\
 && apt-get update -y && apt-get install google-cloud-sdk -y

WORKDIR /app

CMD ["sleep", "infinity"]
