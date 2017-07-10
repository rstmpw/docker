sudo docker run -d \
    --name php-fpm.rstm.app \
    --net docker-rstm-bridge0 \
    -p 9100:9100 \
    -v /vagrant/app:/vagrant/app:ro \
    -v /vagrant/appdata:/vagrant/appdata \
    -v /vagrant/envdata/log/php-fpm/:/var/log/php-fpm \
    rstmpw/php71-fpm

sudo docker stop php-fpm.rstm.app
sudo docker cp /vagrant/environment/php/dev/fpmpool.conf php-fpm.rstm.app:/usr/local/etc/php-fpm.d/app.conf
sudo docker start php-fpm.rstm.app 