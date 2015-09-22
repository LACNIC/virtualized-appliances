FROM ubuntu:15.04
MAINTAINER carlos@xt6.us
WORKDIR /root
# COPY rpki-validator-app-2.20-dist.tar.gz ripeval.tar.gz
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y openjdk-7-jre 
RUN apt-get install -y inetutils-ping rsync
RUN wget -c -q --output-document=ripeval.tar.gz https://lirportal.ripe.net/certification/content/static/validator/rpki-validator-app-2.20-dist.tar.gz
RUN mkdir /root/ripeval
RUN tar xzvf /root/ripeval.tar.gz -C /root/ripeval --strip-components=1
# RUN cd ripeval && ./rpki-validator.sh run
EXPOSE 8080
