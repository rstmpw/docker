FROM php:5.6-fpm-alpine

ENV MUSL_LOCPATH=/usr/share/i18n/locales/musl

RUN apk update \
    && apk add --no-cache libintl gettext \
    && apk add --no-cache --virtual .build-deps unzip cmake make gcc gettext-dev musl-dev \
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
	&& apk add --no-cache libmemcached zlib msgpack-c tzdata \
    && apk add --no-cache --virtual .build-deps autoconf gcc-objc zlib-dev libmemcached-dev msgpack-c-dev \
    && curl -fsSL 'https://github.com/msgpack/msgpack-php/archive/php5.tar.gz' -o msgpack.tar.gz \
    && mkdir -p msgpack \
    && tar -xf msgpack.tar.gz -C msgpack --strip-components=1 \
    && rm msgpack.tar.gz \
    && ( \
        cd msgpack \
        && phpize \
        && ./configure CFLAGS="-O2 -g" --with-msgpack \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r msgpack \
    && docker-php-ext-enable msgpack \
    \
    && curl -fsSL 'https://github.com/igbinary/igbinary/archive/v2.tar.gz' -o igbinary.tar.gz \
    && mkdir -p igbinary \
    && tar -xf igbinary.tar.gz -C igbinary --strip-components=1 \
    && rm igbinary.tar.gz \
    && ( \
        cd igbinary \
        && phpize \
        && ./configure CFLAGS="-O2 -g" --enable-igbinary \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r igbinary \
    && docker-php-ext-enable igbinary \
    \
    && curl -fsSL 'https://pecl.php.net/get/memcached-2.2.0.tgz' -o memcached.tar.gz \
	&& mkdir -p memcached \
	&& tar -xf memcached.tar.gz -C memcached --strip-components=1 \
	&& rm memcached.tar.gz \
	&& ( \
		cd memcached \
		&& phpize \
		&& ./configure CFLAGS="-O2 -g" --enable-memcached-igbinary --enable-memcached-json --enable-memcached-msgpack --disable-memcached-sasl \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r memcached \
	&& docker-php-ext-enable memcached \
	\
	&& curl -fsSL 'https://pecl.php.net/get/memcache-2.2.7.tgz' -o memcache.tar.gz \
    	&& mkdir -p memcache \
    	&& tar -xf memcache.tar.gz -C memcache --strip-components=1 \
    	&& rm memcache.tar.gz \
    	&& ( \
    		cd memcache \
    		&& phpize \
    		&& ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
    		&& make -j$(nproc) \
    		&& make install \
    	) \
    	&& rm -r memcache \
    	&& docker-php-ext-enable memcache \
    \
#    && curl -fsSL 'https://github.com/phpredis/phpredis/archive/4.3.0.tar.gz' -o redis.tar.gz \
#	&& mkdir -p redis \
#	&& tar -xf redis.tar.gz -C redis --strip-components=1 \
#	&& rm redis.tar.gz \
#	&& ( \
#		cd redis \
#		&& phpize \
#		&& ./configure CFLAGS="-O2 -g" --enable-redis-igbinary \
#		&& make -j$(nproc) \
#		&& make install \
#	) \
#	&& rm -r redis \
#	&& docker-php-ext-enable redis \
#	\
	&& apk add --no-cache libpng libpq libjpeg-turbo freetype libxslt libxml2 \
	&& apk add --no-cache --virtual .build-deps libxslt-dev postgresql-dev freetype-dev libpng-dev libjpeg-turbo-dev libxml2-dev \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) opcache mysqli sysvsem sockets bcmath zip xsl soap pgsql pdo_pgsql gd \
	\
	&& apk del .build-deps \
	&& cd /usr/local/etc/php/conf.d \
	&& mv docker-php-ext-igbinary.ini 00-docker-php-ext-igbinary.ini \
	&& mv docker-php-ext-msgpack.ini 01-docker-php-ext-msgpack.ini \
	&& mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
	&& cd /var/www/html/

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8