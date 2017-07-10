sudo docker run -d \
    --name nginx.rstm.app \
    --net docker-rstm-bridge0 \
    -p 80:80 \
    -p 443:443 \
    -v /vagrant/app:/vagrant/app:ro \
    -v /vagrant/appdata/public:/vagrant/appdata/public:ro \
    -v /vagrant/appdata/private:/vagrant/appdata/private:ro \
    -v /vagrant/envdata/log/nginx:/var/log/nginx \
    rstmpw/nginx

sudo docker stop nginx.rstm.app
sudo rm /vagrant/envdata/log/nginx/*
sudo docker cp /vagrant/environment/nginx/dev/vhost.conf nginx.rstm.app:/etc/nginx/conf.d/core7.conf
sudo docker start nginx.rstm.app