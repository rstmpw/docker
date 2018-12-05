FROM postgres:9.6-alpine

RUN mkdir -p /etc/pgsql/conf.d \
    && sed -i "s@^#include_dir = @include_dir = '/etc/pgsql/conf.d'\n#include_dir = @" \
       /usr/local/share/postgresql/postgresql.conf.sample
