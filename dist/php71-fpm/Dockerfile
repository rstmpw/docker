FROM php:7.1-fpm

RUN apt-get update \
    && docker-php-ext-install -j$(nproc) opcache mysqli \
    \
    && apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    \
    && apt-get install -y --no-install-recommends libpq-dev \
    && docker-php-ext-install -j$(nproc) pgsql pdo_pgsql \
    \
    && apt-get install -y --no-install-recommends libxslt-dev \
    && docker-php-ext-install -j$(nproc) xsl soap \
    && apt-get purge --auto-remove -y libxslt-dev \
    \
    && apt-get install -y --no-install-recommends zlib1g-dev \
    && docker-php-ext-install -j$(nproc) zip \
    && apt-get purge --auto-remove -y zlib1g-dev \
    \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    \
    && apt-get autoclean -qy && rm -rf /var/lib/apt/lists/*


#RUN apt-get install -y libbz2-dev
#RUN docker-php-ext-install bz2

RUN mkdir /var/log/php-fpm \
    && cd /usr/local/etc \
    && rm -r php-fpm.d/* \
    && rm php-fpm.conf.default \
    && sed -i 's/^;daemonize = yes/daemonize = no/' php-fpm.conf \
    && sed -i 's/^;error_log .*$/error_log = \/var\/log\/php-fpm\/error.log/' php-fpm.conf