sudo docker run --rm -it \
    --net custom-network-bridge0 \
    -v /vagrant:/vagrant \
    rstmpw/php71cli