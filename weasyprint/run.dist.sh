sudo docker run -d \
    --name weasyweb.local.app \
    -p 4652:4652 \
    --restart=always \
`#	-v /css:/opt/weasyweb/resources/css ` \
`#	-v /log:/opt/weasyweb/log ` \
`#	-v /etc/localtime:/etc/localtime:ro` \
    rstmpw/weasyprint