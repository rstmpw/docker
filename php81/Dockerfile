FROM php:8.1.11-fpm-buster

RUN apt-get update && apt-get upgrade -y \
 	&& apt-get install -y --no-install-recommends procps \
    && apt-get install -y --no-install-recommends locales \
    && echo '' >> /usr/share/locale/locale.alias \
    && sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && sed -i 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen --purge en_US.UTF-8 ru_RU.UTF-8 \
    && echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale \
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
    && curl -fsSL 'https://github.com/igbinary/igbinary/archive/refs/tags/3.2.9.tar.gz' -o igbinary.tar.gz \
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
    && apt-get install -y --no-install-recommends libmemcached11 libhashkit2 libmemcachedutil2 libmemcached-dev libhashkit-dev zlib1g-dev \
    && curl -fsSL 'https://github.com/php-memcached-dev/php-memcached/archive/refs/tags/v3.2.0.tar.gz' -o memcached.tar.gz \
	&& mkdir -p memcached \
	&& tar -xf memcached.tar.gz -C memcached --strip-components=1 \
	&& rm memcached.tar.gz \
	&& ( \
		cd memcached \
		&& phpize \
		&& ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           LDFLAGS="-Wl,-O1 -pie" --enable-memcached --enable-memcached-session --enable-memcached-igbinary --enable-memcached-json --enable-memcached-msgpack --disable-memcached-sasl \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r memcached \
	&& docker-php-ext-enable memcached \
	&& apt-get purge --auto-remove -y libmemcached-dev libhashkit-dev zlib1g-dev \
	\
	&& apt-get install -y --no-install-recommends zlib1g-dev \
	&& curl -fsSL 'https://github.com/websupport-sk/pecl-memcache/archive/refs/tags/8.0.1.tar.gz' -o memcache.tar.gz \
	&& mkdir -p memcache \
	&& tar -xf memcache.tar.gz -C memcache --strip-components=1 \
	&& rm memcache.tar.gz \
	&& ( \
		cd memcache \
		&& phpize \
		&& ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           LDFLAGS="-Wl,-O1 -pie" --enable-memcache \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r memcache \
	&& docker-php-ext-enable memcache \
	&& apt-get purge --auto-remove -y zlib1g-dev \
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
           LDFLAGS="-Wl,-O1 -pie" --enable-redis --enable-redis-igbinary  --enable-redis-msgpack \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r redis \
	&& docker-php-ext-enable redis \
    \
    && apt-get install -y --no-install-recommends librabbitmq4 librabbitmq-dev libssl-dev \
    && curl -fsSL 'https://github.com/php-amqp/php-amqp/archive/refs/heads/master.tar.gz' -o amqp.tar.gz \
    && mkdir -p amqp \
    && tar -xf amqp.tar.gz -C amqp --strip-components=1 \
    && rm amqp.tar.gz \
    && ( \
        cd amqp \
    	&& phpize \
    	&& ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
            CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
            LDFLAGS="-Wl,-O1 -pie" --with-amqp --with-librabbitmq-dir \
    	&& make -j$(nproc) \
    	&& make install \
    ) \
    && rm -r amqp \
    && docker-php-ext-enable amqp \
    && apt-get purge --auto-remove -y librabbitmq-dev libssl-dev \
    \
    && apt-get autoclean -qy && rm -rf /var/lib/apt/lists/* \
    \
    && cd /usr/local/etc/php/conf.d \
    && mv docker-php-ext-igbinary.ini 00-docker-php-ext-igbinary.ini \
    && mv docker-php-ext-msgpack.ini 01-docker-php-ext-msgpack.ini \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && cd /var/www/html/

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#   && pecl install xdebug \
#   && docker-php-ext-enable xdebug \