#!/bin/sh
set -e

rm /etc/crontabs/*
cp /opt/crontabs/* /etc/crontabs/
chown root:root /etc/crontabs/*

cd /etc/crontabs/
for fl in * ; do
  uid=$(echo "$fl" | sed -r 's/^u([0-9]+)$/\1/')
  if [ "$fl" != "$uid" ]; then
    adduser -s /sbin/nologin -D -u "$uid" "$fl" || true
  else
    adduser -s /sbin/nologin -D "$fl" || true
  fi
done

crond -f -d 8