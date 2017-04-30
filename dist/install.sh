#Enable ipv4 forwarding
sudo echo -e "net.ipv4.ip_forward=1\n" > /etc/sysctl.d/90-override.conf
sudo sysctl --system

#Install docker
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce
sudo systemctl start docker
sudo systemctl enable docker

#Define custom docker network
sudo docker network create \
        --driver=bridge \
        --subnet=192.168.183.0/24 \
        --gateway=192.168.183.1 \
        docker-rstm-bridge0