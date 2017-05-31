FROM ubuntu:16.04
LABEL Description="Interface entre DSC y Grafana/Influx"
WORKDIR /root
RUN apt-get update
RUN apt-get install -y vim-tiny git rsync sudo make
RUN apt-get install -y git libmodule-find-perl libxml-libxml-simple-perl libyaml-tiny-perl libcommon-sense-perl libnetaddr-ip-perl cpanminus
RUN cpanm --notest IP::Authority IP::Country::Fast
RUN git clone https://github.com/DNS-OARC/dsc-datatool.git /root/dsc-datatool
RUN /root/dsc-datatool/contrib/iana-dns-parameters/fetch-yaml-for-labler.pl > /root/labler.yaml
VOLUME ["/data"]
