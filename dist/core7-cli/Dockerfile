FROM rstmpw/php71-fpm

RUN mkdir /vagrant \
    && curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
    && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
    && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { echo 'Invalid installer'.PHP_EOL; exit(1);}" \
    && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm -f /tmp/composer-setup.* \
    \
    && apt-get update \
    \
    && apt-get install -y --no-install-recommends postgresql-client \
    && echo "pgsql.rstm.app:5432:postgres:postgres:vagrant" > /root/.pgpass \
    && chmod 600 /root/.pgpass \
    \
    && curl -fsSL 'https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.2.0/flyway-commandline-4.2.0-linux-x64.tar.gz' -o flyway.tar.gz \
    && mkdir -p /usr/local/lib/flyway \
    && tar -xf flyway.tar.gz -C /usr/local/lib/flyway --strip-components=1 \
    && rm flyway.tar.gz \
    && cd /usr/local/bin && ln -s /usr/local/lib/flyway/flyway flyway \
    \
    && apt-get autoclean -qy && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/sh", "-c"]
WORKDIR /vagrant
CMD ["bash"]