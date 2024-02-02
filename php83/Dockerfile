FROM php:8.3.2-fpm-alpine3.19

ENV MUSL_LOCPATH=/usr/share/i18n/locales/musl

COPY entrypoint.cron.sh /usr/local/etc/php/entrypoint.cron.sh
COPY entrypoint.cli.sh /usr/local/etc/php/entrypoint.cli.sh
COPY php-fpm.conf /usr/local/etc/php-fpm.conf
COPY conf/php.ini-cli /etc/php/php.ini-cli
COPY conf/php.ini-fpm /etc/php/php.ini-fpm
COPY conf/php-fpm.d/sample.pool.conf /etc/php/php-fpm.d/sample.pool.conf

RUN set -ex \
    && apk update \
    && apk add --no-cache procps-ng cronie libintl gettext tzdata libmemcached-libs msgpack-c libssh \
        libpng libpq libjpeg-turbo freetype libxslt libxml2 icu libbz2 libzip zlib \
    && apk add --no-cache --virtual .build-deps autoconf unzip cmake make gcc gcc-objc gettext-dev \
        musl-dev libmemcached-dev msgpack-c-dev libssh-dev linux-headers \
        libxslt-dev libpq-dev freetype-dev libpng-dev libjpeg-turbo-dev libxml2-dev icu-dev libzip-dev zlib-dev \
    && curl -fsSL "https://gitlab.com/rilian-la-te/musl-locales/-/archive/master/musl-locales-master.zip" -o musl-locales-master.zip \
    && unzip musl-locales-master.zip \
    && rm musl-locales-master.zip \
    && cd musl-locales-master \
    && cmake -DLOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . \
    && make \
    && make install \
    && cd .. \
    && rm -r musl-locales-master \
    \
    && pecl install msgpack \
    && docker-php-ext-enable msgpack \
    \
    && pecl install igbinary \
    && docker-php-ext-enable igbinary \
    \
    && pecl install memcached \
	&& docker-php-ext-enable memcached \
	\
	&& pecl install memcache \
	&& docker-php-ext-enable memcache \
    \
    && pecl install redis \
	&& docker-php-ext-enable redis \
    \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) opcache mysqli sysvsem sockets bcmath zip xsl soap pgsql pdo_pgsql pdo_mysql gd intl bz2 \
    \
    # XDebug
    && pecl install xdebug \
  	# && docker-php-ext-enable xdebug \
    \
    # install cron
    && mkdir -p /opt/crontabs && rm -rf /etc/periodic \
    \
    && apk del .build-deps \
   	&& cd /usr/local/etc/php/conf.d \
    && mv docker-php-ext-igbinary.ini 00-docker-php-ext-igbinary.ini \
   	&& mv docker-php-ext-msgpack.ini 01-docker-php-ext-msgpack.ini \
   	&& ln -s "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini" \
   	&& ln -s "/etc/php/php.ini-fpm" "${PHP_INI_DIR}/conf.d/override.ini" \
    \
    # install composer \
    && curl https://getcomposer.org/download/latest-stable/composer.phar -o /usr/local/bin/composer && chmod +x /usr/local/bin/composer \
    \
   	&& cd /opt/

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8