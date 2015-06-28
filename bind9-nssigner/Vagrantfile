# Run Docker containers from Vagrant
#

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 53, host: 53
  config.vm.synced_folder "config", "/opt/config"
  config.vm.synced_folder "dfiles", "/opt/dfiles"
  
  config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = false
      # Customize the amount of memory on the VM:
      vb.memory = "2048"
      # name
      vb.name = "docker-nssigner"
   end  
  
  config.vm.provision "shell", inline: <<-SHELL
    sudo mkdir -p /opt/config || /bin/true
    sudo mkdir -p /opt/dfiles || /bin/true
  SHELL
  
  config.vm.provision "docker" do |d|
    d.pull_images "ubuntu:15.04"
    #d.pull_images "debian:wheezy"
    #
    # d.build_image "/vagrant", args: "-t cm2c/ripeval:1.0"
    d.build_image "/opt/dfiles/nssigner", args: "-t cm2c/nssigner:1.0"
    # d.run "cm2c/ripeval:1.0", args: "-p 8080 ./ripeval/rpki-validator.sh"
    #d.run "ripeval_local", image: "cm2c/ripeval:1.0", 
    #  args: "-p 8080:8080", 
    #  daemonize: true,
    #  cmd: "/root/ripeval/rpki-validator.sh run"
  end

  
  config.vm.provision "shell", inline: <<-SHELL
    echo /usr/bin/docker run -d --name nssigner_latest -p 53:53 -p 53:53/udp cm2c/nssigner:1.0 /opt/bbsigner/sbin/named -g -d1
  SHELL

end

