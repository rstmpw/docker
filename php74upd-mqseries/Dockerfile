FROM rstmpw/php74:7.4.33-cli-user-fix

RUN apt-get update \
    && apt-get install -y --no-install-recommends alien \
    && curl -fsSL 'https://files.rstm.pw/mqadv_dev922_linux_x86-64.tar.gz' -o mqc.tar.gz \
    && mkdir -p mqc \
    && tar -xf mqc.tar.gz -C mqc --strip-components=1 \
    && rm mqc.tar.gz \
    && ( \
        cd mqc \
        && sed -i 's/^UNAME_FLAG=-i/UNAME_FLAG=-m/' ./mqlicense.sh \
        && ./mqlicense.sh -accept \
        && alien --scripts --to-deb MQSeriesRuntime-9.2.2-0.x86_64.rpm \
        && dpkg -i mqseriesruntime_9.2.2-1_amd64.deb \
        && alien --scripts --to-deb MQSeriesClient-9.2.2-0.x86_64.rpm \
        && dpkg -i mqseriesclient_9.2.2-1_amd64.deb \
        && alien --scripts --to-deb MQSeriesSDK-9.2.2-0.x86_64.rpm \
        && dpkg -i mqseriessdk_9.2.2-1_amd64.deb \
        && alien --scripts --to-deb MQSeriesSamples-9.2.2-0.x86_64.rpm \
        && dpkg -i mqseriessamples_9.2.2-1_amd64.deb \
    ) \
    && rm -r mqc \
    && printf "\n\
TCP:\n\
  Connect_Timeout=3\n\
CHANNELS:\n\
  CCSID=1208 \n\
" >> /var/mqm/mqclient.ini \
	&& curl -fsSL 'https://github.com/rstmpw/pecl-networking-mqseries/archive/php7-mqmh.tar.gz' -o mqseries.tar.gz \
	&& mkdir -p mqseries \
	&& tar -xf mqseries.tar.gz -C mqseries --strip-components=1 \
	&& rm mqseries.tar.gz \
	&& ( \
		cd mqseries \
		&& phpize \
		&& ./configure CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
           LDFLAGS="-Wl,-O1 -pie" --with-libdir=lib64 \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r mqseries \
	&& docker-php-ext-enable mqseries \
    && apt-get purge --auto-remove -y alien \
    && apt-get autoclean -qy && rm -rf /var/lib/apt/lists/*