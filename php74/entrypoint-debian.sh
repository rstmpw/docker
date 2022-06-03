#!/bin/sh
set -e

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
      adduser --quiet --disabled-login --disabled-password --uid "$uid" "$fl" || true
    else
      adduser --quiet --disabled-login --disabled-password "$fl" || true
    fi
    crontab -u "$fl" "$fl"
  done
fi

exec "$@"