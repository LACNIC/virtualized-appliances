####################################################################################
# Dockerfile for bind 9.10 compiled for DNSSEC signing
#
####################################################################################

FROM ubuntu:15.04
MAINTAINER carlos@xt6.us
WORKDIR /root
RUN apt-get update
RUN apt-get install -y wget inetutils-ping net-tools
RUN apt-get install -y libssl-dev build-essential
RUN wget -q --output-document=bind.tar.gz ftp://ftp.isc.org/isc/bind9/9.10.2/bind-9.10.2.tar.gz
RUN mkdir -p /root/bind
RUN tar xzvf /root/bind.tar.gz -C /root/bind --strip-components=1
WORKDIR /root/bind
RUN ./configure --disable-linux-caps --prefix=/opt/bbsigner
RUN make
RUN make install
RUN cp /v/rndc.conf /opt/bbsigner/etc
ADD http://www.internic.net/domain/named.root /opt/bbsigner/etc/named.root
EXPOSE 53
# /usr/bin/docker run -p 53:53 -p 53:53/udp -v /vagrant:/v cm2c/nssigner:1.0 /opt/bbsigner/sbin/named -g -d1 -c /v/dfiles/nssigner/named.conf

####################################################################################
