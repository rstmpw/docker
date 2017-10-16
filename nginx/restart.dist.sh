sudo docker stop nginx.local.app
sudo docker cp /vagrant/nginx/vhost.dist.conf nginx.local.app:/etc/nginx/conf.d/vhost.conf
sudo docker start nginx.local.app