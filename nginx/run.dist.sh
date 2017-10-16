sudo docker create -d \
    --name nginx.local.app \
    --net custom-network-bridge0 \
    -p 80:80 \
    -p 443:443 \
    -v /vagrant:/vagrant:ro \
    -v /vagrant/someproject/envdata/nginx:/var/log/nginx \
    rstmpw/nginx

sudo docker cp /vagrant/nginx/vhost.dist.conf nginx.local.app:/etc/nginx/conf.d/vhost.conf

sudo docker start nginx.local.app