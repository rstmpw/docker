sudo docker run --rm \
    --net docker-rstm-bridge0 \
    -v /vagrant:/vagrant \
    php:7.1-cli