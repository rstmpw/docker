FROM alpine:3.8

RUN apk update \
	&& apk add --no-cache mariadb-client mariadb-connector-c-dev postgresql-dev curl \
	&& mkdir -pv /opt/sphinx/log /opt/sphinx/binlog /opt/sphinx/index \
	&& curl -fsSL 'https://sphinxsearch.com/files/sphinx-3.3.1-b72d67b-linux-amd64-musl.tar.gz' -o /tmp/sphinx.tar.gz \
	&& cd /opt/sphinx && tar -xf /tmp/sphinx.tar.gz \
	&& rm /tmp/sphinx.tar.gz \
	&& cd /opt/sphinx && mkdir dicts && cd dicts \
	&& curl -fsSL 'https://sphinxsearch.com/files/dicts/ru.pak' -o /opt/sphinx/dicts/ru.pak \
	&& curl -fsSL 'https://sphinxsearch.com/files/dicts/en.pak' -o /opt/sphinx/dicts/en.pak \
	&& cd /opt/sphinx

VOLUME /opt/sphinx/index
VOLUME /opt/sphinx/conf

ENV PATH "${PATH}:/opt/sphinx/sphinx-3.3.1/bin"

RUN ln -sv /dev/stdout /opt/sphinx/log/query.log \
    && ln -sv /dev/stdout /opt/sphinx/log/searchd.log

EXPOSE 9312 9306