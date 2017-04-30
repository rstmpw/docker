sudo docker run -d \
    --name nginx.rstm.app \
    --net docker-rstm-bridge0 \
    -p 80:80 \
    -p 443:443 \
    -v /vagrant/environment/nginx/dev/vhost.conf:/etc/nginx/conf.d/core7.conf:ro \
    -v /vagrant/app/:/srv/core7.rstm.app/app:ro \
    -v /vagrant/appdata/:/srv/core7.rstm.app/appdata:ro \
    rstmpw/nginx