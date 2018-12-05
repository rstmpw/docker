FROM php:7.1-fpm

RUN apt-get update \
    && apt-get install -y --no-install-recommends locales \
    && echo '' >> /usr/share/locale/locale.alias \
    && sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen --purge en_US.UTF-8 \
    && echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale \
    \
    && docker-php-ext-install -j$(nproc) opcache mysqli \
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
    && apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
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
    && curl -fsSL 'https://github.com/phpredis/phpredis/archive/4.2.0.tar.gz' -o redis.tar.gz \
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

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8