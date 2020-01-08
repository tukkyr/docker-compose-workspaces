FROM node:buster

RUN apt-get update && apt-get install -y vim git && rm -rf /var/lib/apt/lists/*

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
 && apt-get install -y git-lfs \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g firebase-tools

WORKDIR /app

CMD ["sleep", "infinity"]
