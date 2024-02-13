#!/bin/sh
set -e

if [ -f /etc/php/php.ini-cli ]; then
  rm "${PHP_INI_DIR}/conf.d/override.ini"
  ln -s "/etc/php/php.ini-cli" "${PHP_INI_DIR}/conf.d/override.ini"
fi

if [ ! -d /var/spool/cron/crontabs ]; then
  mkdir -p /var/spool/cron/crontabs
elif [ "$(ls -A /var/spool/cron/crontabs)" ]; then
  rm /var/spool/cron/crontabs/*
fi

if [ "$(ls -A /opt/crontabs)" ]; then
  cd /opt/crontabs
  for fl in * ; do
    uid=$(echo "$fl" | sed -r 's/^u([0-9]+)$/\1/')
    if [ "$fl" != "$uid" ]; then
      adduser --disabled-login --disabled-password --gecos "" --uid "$uid" "$fl" || true
    else
      adduser --disabled-login --disabled-password --gecos "" "$fl" || true
    fi
    crontab -u "$fl" "$fl"
  done
fi

syslogd -O /proc/1/fd/1 -S

cron -f