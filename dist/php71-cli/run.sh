sudo docker run -d \
    --name php-cli \
    --net docker-rstm-bridge0 \
    -v /vagrant:/vagrant \
    php:7.1-fpm