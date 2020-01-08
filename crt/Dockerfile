FROM debian:10

RUN apt-get update \
 && apt-get install -y openssl \
 && rm -rf /var/lib/apt/lists/*
  
WORKDIR /crt

CMD ["sleep", "infinity"]
