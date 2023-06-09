#!/bin/sh

if [ -f /etc/php/php.ini-cli ]; then
  rm "${PHP_INI_DIR}/conf.d/override.ini"
  ln -s "/etc/php/php.ini-cli" "${PHP_INI_DIR}/conf.d/override.ini"
fi

if [ ! -f "$1" ]; then
    echo "Script $1 not found"
    exit 2
fi

php -f "$@"