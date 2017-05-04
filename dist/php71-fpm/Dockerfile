FROM php:7.1-fpm

RUN apt-get update \
    && docker-php-ext-install -j$(nproc) opcache mysqli \
    \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    \
    && apt-get install -y --no-install-recommends zlib1g-dev \
    && docker-php-ext-install -j$(nproc) zip \
    && apt-get purge --auto-remove -y zlib1g-dev \
    \
    && apt-get install -y --no-install-recommends libxslt-dev \
    && docker-php-ext-install -j$(nproc) xsl soap \
    && apt-get purge --auto-remove -y libxslt-dev \
    \
    && apt-get install -y --no-install-recommends libpq-dev \
    && docker-php-ext-install -j$(nproc) pgsql pdo_pgsql \
    \
    && apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    \
    && pecl install msgpack \
    && docker-php-ext-enable msgpack \
    \
    && curl -fsSL 'https://github.com/igbinary/igbinary/archive/master.tar.gz' -o igbinary.tar.gz \
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
    && apt-get install -y --no-install-recommends libmemcached-dev \
    && curl -fsSL 'https://github.com/php-memcached-dev/php-memcached/archive/master.tar.gz' -o memcached.tar.gz \
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
    && curl -fsSL 'https://github.com/phpredis/phpredis/archive/3.1.2.tar.gz' -o redis.tar.gz \
	&& mkdir -p redis \
	&& tar -xf redis.tar.gz -C redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& ( \
		cd redis \
		&& phpize \
		&& ./configure CFLAGS="-O2 -g" --enable-redis-igbinary \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r redis \
	&& docker-php-ext-enable redis \
    \
    && apt-get autoclean -qy && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/log/php-fpm \
    && cd /usr/local/etc \
    && rm -r php-fpm.d/* \
    && rm php-fpm.conf.default \
    && sed -i 's/^;daemonize = yes/daemonize = no/' php-fpm.conf \
    && sed -i 's/^;error_log .*$/error_log = \/var\/log\/php-fpm\/error.log/' php-fpm.conf