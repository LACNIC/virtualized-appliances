FROM debian:buster
RUN apt -y update && apt -y dist-upgrade
RUN apt -y install autoconf automake build-essential libjansson-dev libssl-dev pkg-config rsync wget
WORKDIR /root
RUN wget https://github.com/NICMx/FORT-validator/releases/download/v1.0.0/fort-1.0.0.tar.gz
RUN tar xzvf fort-1.0.0.tar.gz
WORKDIR /root/fort-1.0.0
RUN ./configure
RUN make && make install
RUN fort -V

