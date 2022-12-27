FROM node:18.12.1-bullseye-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends alien curl ca-certificates python3 make gcc g++ \
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
    && echo -e "\n\
TCP: \n\
	 Connect_Timeout=3 \n\
CHANNELS: \n\
	 CCSID=1208 \n\
" >> /var/mqm/mqclient.ini \
    && apt-get purge --auto-remove -y alien \
    && apt-get autoclean -qy && rm -rf /var/lib/apt/lists/* \
    && npm install pm2 -g