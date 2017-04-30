mkdir -p /srv/docker/nginx/wwwdata
mkdir -p /srv/docker/nginx/conf/conf.d

docker stop ngimx.rstm.app
docker rm nginx.rstm.app
docker rmi rstmpw/nginx

bash <(curl -Ls https://raw.githubusercontent.com/rstmpw/docker/master/dist/nginx/build.sh)
bash <(curl -Ls https://raw.githubusercontent.com/rstmpw/docker/master/dist/nginx/run.sh)

docker cp nginx.rstm.app:/etc/nginx/conf.d /srv/docker/nginx/conf/conf.d

docker restart nginx.rstm.app