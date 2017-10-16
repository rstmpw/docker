sudo docker stop php71fpm.local.app
sudo docker cp /vagrant/php71/pool.dist.conf php71fpm.local.app:/usr/local/etc/php-fpm.d/pool.conf
sudo docker start php71fpm.local.app