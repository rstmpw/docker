#!/bin/sh
set -e

if [ -f /etc/php/php.ini-cli ]; then
  rm "${PHP_INI_DIR}/conf.d/override.ini"
  ln -s "/etc/php/php.ini-cli" "${PHP_INI_DIR}/conf.d/override.ini"
fi

rm /etc/crontabs/*
cp /opt/crontabs/* /var/spool/cron/crontabs/
chown root:root /var/spool/cron/crontabs/*
chmod 0600 /var/spool/cron/crontabs/*

cd /var/spool/cron/crontabs
for fl in * ; do
  uid=$(echo "$fl" | sed -r 's/^u([0-9]+)$/\1/')
  if [ "$fl" != "$uid" ]; then
    adduser -s /sbin/nologin -D -u "$uid" "$fl" || true
  else
    adduser -s /sbin/nologin -D "$fl" || true
  fi
done

syslogd -O /proc/1/fd/1 -S

crond -f -s