sudo docker run --rm -it \
    --net docker-rstm-bridge0 \
    -v /vagrant:/vagrant \
    rstmpw/php71-cli