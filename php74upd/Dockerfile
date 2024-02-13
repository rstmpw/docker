FROM php:7.4.33-fpm-buster

COPY entrypoint.cron.sh /usr/local/etc/php/entrypoint.cron.sh
COPY entrypoint.cli.sh /usr/local/etc/php/entrypoint.cli.sh
COPY php-fpm.conf /usr/local/etc/php-fpm.conf
COPY conf/php.ini-cli /etc/php/php.ini-cli
COPY conf/php.ini-fpm /etc/php/php.ini-fpm
COPY conf/php-fpm.d/sample.pool.conf /etc/php/php-fpm.d/sample.pool.conf

RUN apt-get update \
 	&& apt-get install -y --no-install-recommends procps \
    && apt-get install -y --no-install-recommends locales \
    && echo '' >> /usr/share/locale/locale.alias \
    && sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && sed -i 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen --purge en_US.UTF-8 ru_RU.UTF-8 \
    && printf "LANG=\"en_US:UTF-8\"\nLC_ALL=\"en_US:UTF-8\"\n" > /etc/default/locale \
    \
    && apt-get install -y --no-install-recommends libicu-dev \
    && docker-php-ext-install -j$(nproc) intl \
    && apt-get purge --auto-remove -y libicu-dev \
    \
    && docker-php-ext-install -j$(nproc) opcache mysqli pdo_mysql sysvsem sockets bcmath \
    \
    && apt-get install -y --no-install-recommends libbz2-dev \
    && docker-php-ext-install -j$(nproc) bz2 \
    && apt-get purge --auto-remove -y libbz2-dev \
    \
    && apt-get install -y --no-install-recommends zlib1g-dev libzip4 libzip-dev \
    && docker-php-ext-install -j$(nproc) zip \
    && apt-get purge --auto-remove -y zlib1g-dev libzip-dev \
    \
    && apt-get install -y --no-install-recommends libxslt-dev \
    && docker-php-ext-install -j$(nproc) xsl soap \
    && apt-get purge --auto-remove -y libxslt-dev \
    \
    && apt-get install -y --no-install-recommends libpq5 libpq-dev \
    && docker-php-ext-install -j$(nproc) pgsql pdo_pgsql \
    && apt-get purge --auto-remove -y libpq-dev \
    \
    && apt-get install -y --no-install-recommends libfreetype6 libfreetype6-dev libjpeg62-turbo libjpeg62-turbo-dev libpng16-16 libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && apt-get purge --auto-remove -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    \
    && pecl install msgpack \
    && docker-php-ext-enable msgpack \
    \
    && pecl install --configureoptions 'enable-igbinary="yes"' igbinary \
    && docker-php-ext-enable igbinary \
    \
    && apt-get install -y --no-install-recommends libmemcached11 libhashkit2 libmemcachedutil2 libmemcached-dev libhashkit-dev zlib1g-dev \
    && pecl install --configureoptions 'enable-memcached-igbinary="yes" enable-memcached-session="yes" enable-memcached-json="yes" enable-memcached-msgpack="yes"' memcached \
    && docker-php-ext-enable memcached \
    && apt-get purge --auto-remove -y libmemcached-dev libhashkit-dev zlib1g-dev \
	\
	&& apt-get install -y --no-install-recommends zlib1g-dev \
	&& pecl install memcache-4.0.5.2 \
    && docker-php-ext-enable memcache \
	&& apt-get purge --auto-remove -y zlib1g-dev \
    \
    && pecl install --configureoptions 'enable-redis-igbinary="yes"' redis \
    && docker-php-ext-enable redis \
    \
    && apt-get install -y --no-install-recommends librabbitmq4 librabbitmq-dev libssl-dev \
    && pecl install amqp \
    && docker-php-ext-enable amqp \
    && apt-get purge --auto-remove -y librabbitmq-dev libssl-dev \
    \
    # XDebug
    && pecl install xdebug-3.1.5 \
    # && docker-php-ext-enable xdebug \
    \
    && cd /usr/local/etc/php/conf.d \
    && mv docker-php-ext-igbinary.ini 00-docker-php-ext-igbinary.ini \
    && mv docker-php-ext-msgpack.ini 01-docker-php-ext-msgpack.ini \
  	&& ln -s "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini" \
    && ln -s "/etc/php/php.ini-fpm" "${PHP_INI_DIR}/conf.d/override.ini" \
    \
    # install composer \
    && curl https://getcomposer.org/download/latest-stable/composer.phar -o /usr/local/bin/composer && chmod +x /usr/local/bin/composer \
    \
    # install cron & rsyslog
    && apt-get install -y --no-install-recommends cron busybox-syslogd \
    && sed -i '/^session.*pam_unix.so\s*/i session [success=1 default=ignore] pam_succeed_if.so service in cron quiet use_uid' /etc/pam.d/common-session-noninteractive \
    && rm -rf /etc/cron.*/* \
    && mkdir -p /opt/crontabs \
    \
    && apt-get autoclean -qy && rm -rf /var/lib/apt/lists/* \
    \
    && cd /opt/

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8