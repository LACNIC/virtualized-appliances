#!/bin/bash
# Author- Dario Gomez

if [ -d /opt/splunk ]
then
	echo "******************************** Ya esta todo instalado ******************************"

else

	# Updating repository
	sudo apt-get -y update
	
	echo "******************************** Setear Locate ***********************************"
	sudo apt-get install language-pack-UTF-8
	sudo locale-gen UTF-8

	echo "******************************** Instalando Splunk *******************************"
	#Splunk
	sudo dpkg -i /vagrant/splunklight*.deb
	
	echo "******************************** Iniciando Splunk *******************************"
	#start Splunk
	sudo /opt/splunk/bin/splunk start --accept-license
	
	echo "******************************** Auto Start Splunk *******************************"
	#Enable auto-start
	sudo /opt/splunk/bin/splunk enable boot-start
	#Seteo el path de splunk
	sudo echo 'export PATH=$PATH:/opt/splunk/bin' >> /home/vagrant/.bashrc
	#sudo su
	#echo 'PATH=$PATH:/opt/splunk/bin' > /etc/environment
	exit
	
	echo "******************************** Instalación finalizada *******************************"
fi

# No es necesario correr el start, ya lo hace automatico ahora
#echo "******************************** Iniciando Splunk ********************************"
#start Splunk
#sudo su
#/opt/splunk/bin/splunk start --accept-license

