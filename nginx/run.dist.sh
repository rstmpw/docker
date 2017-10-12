sudo docker run -d \
    --name nginx.local.app \
    --net custom-network-bridge0 \
    -p 80:80 \
    -p 443:443 \
    -v /vagrant:/vagrant:ro \
    -v /vagrant/appdata/public:/vagrant/appdata/public:ro \
    -v /vagrant/appdata/private:/vagrant/appdata/private:ro \
    -v /vagrant/envdata/nginxlog:/var/log/nginx \
    rstmpw/nginx

sudo docker stop nginx.local.app
sudo docker cp /vagrant/environment/nginx/dev/vhost.conf nginx.local.app:/etc/nginx/conf.d/vhost.conf
sudo docker start nginx.local.app