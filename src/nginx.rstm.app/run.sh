docker run -d \
    --name nginx.rstm.app \
    -p 80:80 \
    -p 443:443 \
    -v /vagrant:/usr/share/nginx/html:ro \
    nginx