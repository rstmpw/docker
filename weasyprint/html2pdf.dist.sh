#run.sh html pdf

sudo docker run --rm -it \
    -v /vagrant/tmp:/opt/pfraf \
    rstmpw/weasyprint html2pdf "$1" "$2"