#!/bin/sh
set -e

rm /etc/crontabs/*
cp /opt/crontabs/* /etc/crontabs/
chown root:root /etc/crontabs/*

exec "$@"