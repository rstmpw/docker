sudo docker create \
    --name php71fpm.local.app \
    --net custom-network-bridge \
    -v /vagrant/someproject/app:/vagrant/someproject/app:ro \
    -v /vagrant/someproject/envdata/php:/var/log/php-fpm \
    rstmpw/php71

sudo docker cp /vagrant/php71/pool.dist.conf php71fpm.local.app:/usr/local/etc/php-fpm.d/pool.conf

sudo docker start php71fpm.local.app