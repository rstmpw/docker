FROM fluent/fluentd:v1.16-1

USER root

RUN apk update \
    && apk add --no-cache tzdata libpq \
    && apk add --no-cache --virtual .build-deps sudo build-base ruby-dev libpq-dev \
    && sudo gem install fluent-plugin-elasticsearch \
#    && sudo gem install tzinfo -v '< 2' --no-document && sudo gem uninstall tzinfo -v '>= 2' && \
    && sudo gem install fluent-plugin-sql --no-document && sudo gem install pg --no-document \
    && sudo gem sources --clear-all \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

#COPY fluent.conf /fluentd/etc/
#COPY entrypoint.sh /bin/

USER fluent