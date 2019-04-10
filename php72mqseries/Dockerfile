FROM rstmpw/php72:7.2.16-1913


RUN apt-get update \
    && apt-get install -y --no-install-recommends alien \
    && curl -fsSL 'https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev90_linux_x86-64.tar.gz' -o mqc.tar.gz \
    && mkdir -p mqc \
    && tar -xf mqc.tar.gz -C mqc --strip-components=1\
    && rm mqc.tar.gz \
    && ( \
        cd mqc \
        && sed -i 's/^UNAME_FLAG=-i/UNAME_FLAG=-m/' ./mqlicense.sh \
        && ./mqlicense.sh -accept \
        && alien --scripts --to-deb MQSeriesRuntime-9.0.0-0.x86_64.rpm \
        && dpkg -i mqseriesruntime_9.0.0-1_amd64.deb \
        && alien --scripts --to-deb MQSeriesClient-9.0.0-0.x86_64.rpm \
        && dpkg -i mqseriesclient_9.0.0-1_amd64.deb \
        && alien --scripts --to-deb MQSeriesSDK-9.0.0-0.x86_64.rpm \
        && dpkg -i mqseriessdk_9.0.0-1_amd64.deb \
        && alien --scripts --to-deb MQSeriesSamples-9.0.0-0.x86_64.rpm \
        && dpkg -i mqseriessamples_9.0.0-1_amd64.deb \
    ) \
    && rm -r mqc \
    && echo -e "\n\
TCP: \n\
	 Connect_Timeout=3 \n\
CHANNELS: \n\
	 CCSID=1208 \n\
" >> /var/mqm/mqclient.ini \
	&& curl -fsSL 'https://github.com/rstmpw/pecl-networking-mqseries/archive/php7-mqmh.tar.gz' -o mqseries.tar.gz \
	&& mkdir -p mqseries \
	&& tar -xf mqseries.tar.gz -C mqseries --strip-components=1 \
	&& rm mqseries.tar.gz \
	&& ( \
		cd mqseries \
		&& phpize \
		&& ./configure CFLAGS="-O2 -g" --with-libdir=lib64 \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r mqseries \
	&& docker-php-ext-enable mqseries \
    && apt-get purge --auto-remove -y alien \
    && apt-get autoclean -qy && rm -rf /var/lib/apt/lists/*

