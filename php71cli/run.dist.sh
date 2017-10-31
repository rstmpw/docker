sudo docker run --rm -it \
    --net custom-network-bridge0 \
    -v /vagrant:/vagrant \
    -w /vagrant/someproject/app \
    rstmpw/php71cli php -f "$@"