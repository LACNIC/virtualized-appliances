FROM debian:wheezy
MAINTAINER carlos@xt6.us
WORKDIR /root
RUN apt-get update
RUN apt-get install -y wget sudo
RUN apt-get install -y inetutils-ping rsync
RUN wget -q -O - http://download.rpki.net/APT/apt-gpg-key.asc | sudo apt-key add -
# RUN tar xzvf /root/ripeval.tar.gz -C /root/ripeval --strip-components=1
RUN sudo wget -q -O /etc/apt/sources.list.d/rpki.list http://download.rpki.net/APT/rpki.wheezy.list
RUN sudo apt-get update
RUN sudo apt-get install -y rpki-rp rpki-ca
