sudo docker run --rm \
    --net docker-rstm-bridge0 \
    -v /vagrant:/vagrant \
    rstmpw/php71-cli