FROM php:8.2.6-fpm-alpine3.18

ENV MUSL_LOCPATH=/usr/share/i18n/locales/musl

RUN set -ex \
    && apk update \
    && apk add --no-cache procps-ng libintl gettext tzdata libmemcached-libs msgpack-c libssh \
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
    && curl -fsSL 'https://github.com/msgpack/msgpack-php/archive/refs/tags/msgpack-2.2.0RC2.tar.gz' -o msgpack.tar.gz \
    && mkdir -p msgpack \
    && tar -xf msgpack.tar.gz -C msgpack --strip-components=1 \
    && rm msgpack.tar.gz \
    && ( \
        cd msgpack \
        && phpize \
        && ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
    		CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
    		LDFLAGS="-Wl,-O1 -pie" --with-msgpack \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r msgpack \
    && docker-php-ext-enable msgpack \
    \
	&& curl -fsSL 'https://github.com/igbinary/igbinary/archive/refs/tags/3.2.14.tar.gz' -o igbinary.tar.gz \
    && mkdir -p igbinary \
    && tar -xf igbinary.tar.gz -C igbinary --strip-components=1 \
    && rm igbinary.tar.gz \
    && ( \
        cd igbinary \
        && phpize \
        && ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
    		CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
    		LDFLAGS="-Wl,-O1 -pie" --enable-igbinary \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r igbinary \
    && docker-php-ext-enable igbinary \
    \
    && curl -fsSL 'https://github.com/php-memcached-dev/php-memcached/archive/refs/tags/v3.2.0.tar.gz' -o memcached.tar.gz \
	&& mkdir -p memcached \
	&& tar -xf memcached.tar.gz -C memcached --strip-components=1 \
	&& rm memcached.tar.gz \
	&& ( \
		cd memcached \
		&& phpize \
		&& ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           LDFLAGS="-Wl,-O1 -pie" --enable-memcached-igbinary --enable-memcached-json --enable-memcached-msgpack --disable-memcached-sasl \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r memcached \
	&& docker-php-ext-enable memcached \
	\
	&& curl -fsSL 'https://github.com/websupport-sk/pecl-memcache/archive/refs/tags/8.2.tar.gz' -o memcache.tar.gz \
	&& mkdir -p memcache \
	&& tar -xf memcache.tar.gz -C memcache --strip-components=1 \
	&& rm memcache.tar.gz \
	&& ( \
		cd memcache \
		&& phpize \
		&& ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           LDFLAGS="-Wl,-O1 -pie" \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r memcache \
	&& docker-php-ext-enable memcache \
    \
    && curl -fsSL 'https://github.com/phpredis/phpredis/archive/refs/tags/5.3.7.tar.gz' -o redis.tar.gz \
	&& mkdir -p redis \
	&& tar -xf redis.tar.gz -C redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& ( \
		cd redis \
		&& phpize \
		&& ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           LDFLAGS="-Wl,-O1 -pie" --enable-redis-igbinary \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r redis \
	&& docker-php-ext-enable redis \
    \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) opcache mysqli sysvsem sockets bcmath zip xsl soap pgsql pdo_pgsql pdo_mysql gd intl bz2 \
    \
    # install cron
    && mkdir -p /opt/crontabs && rm -rf /etc/periodic \
#   && pecl install xdebug \
#   && docker-php-ext-enable xdebug \
    \
    && apk del .build-deps \
   	&& cd /usr/local/etc/php/conf.d \
    && mv docker-php-ext-igbinary.ini 00-docker-php-ext-igbinary.ini \
   	&& mv docker-php-ext-msgpack.ini 01-docker-php-ext-msgpack.ini \
   	&& mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
   	&& cd /var/www/html/

VOLUME ["/opt/crontabs"]

COPY entrypoint.cron.sh /usr/local/etc/php/entrypoint.cron.sh
COPY entrypoint.cli.sh /usr/local/etc/php/entrypoint.cli.sh

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#   && pecl install xdebug \
#   && docker-php-ext-enable xdebug \