# run.sh schema xml html pdf


sudo docker run --rm -it \
    -v /vagrant/tmp:/opt/pfraf \
    rstmpw/weasyprint xml2pdf "$1" "$2" "$3" "$4"