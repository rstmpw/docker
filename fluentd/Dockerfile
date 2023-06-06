FROM fluent/fluentd:v1.16-1

USER root

RUN apk update \
    && apk add --no-cache tzdata libpq \
    && apk add --no-cache --virtual .build-deps build-base ruby-dev libpq-dev \
    && gem install fluent-plugin-elasticsearch \
#    && gem install tzinfo -v '< 2' --no-document && gem uninstall tzinfo -v '>= 2' && \
    && gem install fluent-plugin-sql --no-document && gem install pg --no-document \
    && gem install fluent-plugin-record-modifier --no-document \
    && gem sources --clear-all \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

#COPY fluent.conf /fluentd/etc/
#COPY entrypoint.sh /bin/

USER fluent