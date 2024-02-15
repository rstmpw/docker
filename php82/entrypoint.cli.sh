#!/bin/sh

if [ -f /etc/php/php.ini-cli ]; then
    rm "${PHP_INI_DIR}/conf.d/override.ini"
    ln -s "/etc/php/php.ini-cli" "${PHP_INI_DIR}/conf.d/override.ini"
fi

if [ ! -f "$1" ]; then
    echo "Script $1 not found"
    exit 2
fi

if [ -z "${PHP_CLI_USER}" ]; then
    php -f "$@"
else
    uid=$(echo "${PHP_CLI_USER}" | sed -r 's/^u([0-9]+)$/\1/')
    if [ "${PHP_CLI_USER}" != "$uid" ]; then
        adduser -s /sbin/nologin -D -u "$uid" "${PHP_CLI_USER}" || true
    else
        adduser -s /sbin/nologin -D "${PHP_CLI_USER}" || true
    fi

    runuser -u "${PHP_CLI_USER}" -p -- php -f "$@"
fi