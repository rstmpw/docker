sudo docker run -d \
    --name weasyweb.local.app \
    -p 4652:4652 \
    -v /vagrant/weasyprint/weasyweb/html2pdf/resources/css:/opt/weasyweb/html2pdf/resources/css \
    rstmpw/weasyprint