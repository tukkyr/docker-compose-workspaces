FROM debian:10

RUN apt-get update \
 && apt-get install -y curl gnupg lsb-release vim git jq bash-completion \
 && rm -rf /var/lib/apt/lists/*

COPY .vimrc /root/.vimrc

RUN curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
 && vim -c PlugInstall -c q -c q

RUN CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
 && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
 && apt-get update && apt-get install -y google-cloud-sdk \
 && rm -rf /var/lib/apt/lists/*

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin/kubectl

RUN echo "source /etc/bash_completion" >> ${HOME}/.bashrc \
 && echo "source <(kubectl completion bash)"  >> ${HOME}/.bashrc

WORKDIR /k8s

CMD ["sleep", "infinity"]
