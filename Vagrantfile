# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "CentOS7"
  config.vm.box_url = "http://files.rstm.pw/vagrant/CentOS7.json"

  config.vm.network "private_network", ip: "192.168.222.200"

  # Prev run on vagrant host:
  # vagrant plugin install vagrant-vbguest
  config.vm.synced_folder "./", "/vagrant", type: "virtualbox"

  config.vm.provider "virtualbox" do |vbox|
    vbox.name = "SomeProject"

    # Get disk path
    def_folder = `VBoxManage list systemproperties | grep "Default machine folder"`
    machine_folder = def_folder.split(':')[1].strip()
    second_disk = File.join(machine_folder, vbox.name, 'disk2.vmdk')

    # Create and attach disk 10G
    unless File.exist?(second_disk)
      vbox.customize [ "createmedium", "disk", "--filename", second_disk, "--format", "vmdk", "--size", 1024 * 10 + 1 ]
    end
    vbox.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 0, '--device', 1, '--type', 'hdd', '--medium', second_disk]
  end

  # Create and mount fs on 10G disk
  config.vm.provision "shell", inline: <<-SHELL
    sudo yum install -y system-storage-manager
    sudo mkdir /opt/SomeProject
    sudo ssm create -s 10G -n ProjectLV --fstype xfs -p ProjectVG /dev/sdb /opt/SomeProject
    echo "/dev/mapper/ProjectVG-ProjectLV /opt/SomeProject        xfs     defaults        0 0" | sudo tee -a /etc/fstab
  SHELL

  # Install docker and create custom network
  config.vm.provision "shell", name: "Docker", inline: <<-SHELL
    bash <(curl -Ls https://raw.githubusercontent.com/rstmpw/docker/master/install.centos7.sh)
    /vagrant/createCustomNet.sh
  SHELL

#  # Run nginx
#  config.vm.provision "shell", name: "Nginx", inline: <<-SHELL
#    /vagrant/nginx/run.dist.sh
#  SHELL

#  # Run PHP
#  config.vm.provision "shell", name: "PHP", inline: <<-SHELL
#    /vagrant/php71/run.dist.sh
#  SHELL

#  config.vm.provision "shell", run: "always", inline: <<-SHELL
#  	sudo docker start php71fpm.local.app
#  	sudo docker start nginx.local.app
#  SHELL
end