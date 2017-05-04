FROM php:7.1-fpm

RUN apt-get update \
    && docker-php-ext-install opcache \
    \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    \
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo_pgsql \
    && apt-get purge -y --auto-remove libfreetype6-dev libjpeg62-turbo-dev libpng12-dev

RUN mkdir /var/log/php-fpm \
    && cd /usr/local/etc \
    && rm -r php-fpm.d/* \
    && rm php-fpm.conf.default \
    && sed -i 's/^;daemonize = yes/daemonize = no/' php-fpm.conf \
    && sed -i 's/^;error_log .*$/error_log = \/var\/log\/php-fpm\/error.log/' php-fpm.conf