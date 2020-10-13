FROM golang:1.15-buster

RUN apt-get update && apt-get install --no-install-recommends -y ack-grep lsb-release peco tree jq ssh-client unzip graphviz rsync && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ${HOME}/.git-prompt.sh
RUN curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY .vimrc /root
COPY .bashrc /root

WORKDIR /root

RUN wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage \
 && chmod u+x nvim.appimage \
 && ./nvim.appimage --appimage-extract \
 && echo 'export PATH=$PATH:$HOME/squashfs-root/usr/bin' >> $HOME/.bashrc \
 && mkdir -p $HOME/.config \
 && ln -s $HOME/.vim $HOME/.config/nvim \
 && ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim

COPY coc-settings.json /root/.config/nvim

ARG PROT_VER=3.13.0

RUN go get -u google.golang.org/grpc \
 && go get -u github.com/golang/protobuf/protoc-gen-go \
 && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
 && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger \
 && GO111MODULE=off go get github.com/oxequa/realize \
 && wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROT_VER}/protoc-${PROT_VER}-linux-x86_64.zip \
 && mkdir build \
 && unzip protoc-${PROT_VER}-linux-x86_64.zip -d build \
 && mv build/include/* /usr/local/include/ \
 && mv build/bin/protoc /usr/local/bin \
 && rm -rf protoc-${PROT_VER}-linux-x86_64.zip build

RUN go get -u golang.org/x/tools/cmd/godoc \
 && go get -u github.com/kisielk/errcheck \
 && go get -u github.com/x-motemen/ghq

ARG username
ARG email

RUN set -u \
 && git config --global ghq.root $GOPATH/src \
 && git config --global credential.helper cache \
 && git config --global user.name ${username} \
 && git config --global user.email ${email}

RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"\
 && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
 && apt-get update -y && apt-get install google-cloud-sdk -y \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install --no-install-recommends -y default-jre && rm -rf /var/lib/apt/lists/*

RUN curl -fLo /usr/local/bin/firebase https://firebase.tools/bin/linux/latest \
 && chmod +x /usr/local/bin/firebase

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
 && apt-get install -y nodejs \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn \
 && yarn global add diagnostic-languageserver

WORKDIR /root

RUN apt-get update && apt-get install -y python3-pip python-pip \
 && pip3 install neovim \
 && pip install neovim \
 && rm -rf /var/lib/apt/lists/*

CMD ["sleep", "infinity"]
