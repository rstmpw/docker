#Define custom docker network
sudo docker network create \
        --driver=bridge \
        --subnet=192.168.183.0/24 \
        --gateway=192.168.183.1 \
        custom-network-bridge