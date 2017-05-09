sudo docker run -d \
    --name php-fpm.rstm.app \
    --net docker-rstm-bridge0 \
    -p 9100:9100 \
    -v /vagrant/app:/srv/core7.rstm.app/app:ro \
    -v /vagrant/appdata:/srv/core7.rstm.app/appdata \
    -v /vagrant/appdata/envlog/php-fpm:/var/log/php-fpm \
    rstmpw/php71-fpm