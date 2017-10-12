sudo docker run -d \
    --name php71fpm.local.app \
    --net custom-network-bridge0 \
    -p 9100:9100 \
    -v /vagrant/app:/vagrant/app:ro \
    -v /vagrant/appdata:/vagrant/appdata \
    -v /vagrant/envdata/phplog/:/var/log/php-fpm \
    rstmpw/php71

sudo docker stop php71fpm.local.app
sudo docker cp /vagrant/environment/php/dev/pool.conf php71fpm.local.app:/usr/local/etc/php-fpm.d/pool.conf
sudo docker start php71fpm.local.app