FROM php:7.1-fpm

RUN docker-php-ext-install opcache \
    && mkdir /var/log/php-fpm \
    && cd /usr/local/etc \
    && rm -r php-fpm.d/* \
    && rm php-fpm.conf.default \
    && sed -i 's/^;daemonize = yes/daemonize = no/' php-fpm.conf \
    && sed -i 's/^;error_log .*$/error_log = \/var\/log\/php-fpm\/error.log/' php-fpm.conf