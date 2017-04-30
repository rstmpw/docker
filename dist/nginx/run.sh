docker run -d \
    --name nginx.rstm.app \
    --net docker-rstm-bridge0 \
    -p 80:80 \
    -p 443:443 \
    -v /vagrant:/usr/share/nginx/html:ro \
    rstmpw/nginx