FROM postgres:9.6-alpine

RUN mkdir -p /var/log/pgsql \
    && mkdir -p /etc/pgsql/conf.d \
    && sed -i "s@^#include_dir = @include_dir = '/etc/pgsql/conf.d'\n#include_dir = @" \
       /usr/local/share/postgresql/postgresql.conf.sample \
    && echo -e " \n\
    logging_collector = on \n\
    log_directory = '/var/log/pgsql' \n\
    log_timezone = 'Europe/Moscow' \n\
    timezone = 'Europe/Moscow' \n\
    " >> /etc/pgsql/conf.d/10-override.conf
