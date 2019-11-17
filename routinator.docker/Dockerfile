FROM debian:buster
RUN apt-get update && apt-get -y dist-upgrade && apt-get -y install curl build-essential rsync
WORKDIR /root
COPY compile.sh /root
RUN /bin/bash compile.sh
RUN cp .cargo/bin/routinator /usr/local/bin
RUN routinator init --accept-arin-rpa
