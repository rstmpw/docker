FROM alpine:3.6
MAINTAINER RSTM Team "team@rstm.pw"

ENV LANG=ru_RU.UTF-8

RUN apk add --no-cache python3 cairo pango jpeg-dev \
    && apk add --no-cache --virtual build-dependencies build-base linux-headers pcre-dev python3-dev libffi-dev musl-dev zlib-dev gcc glib msttcorefonts-installer ca-certificates\
    && pip3 install --upgrade pip \
    && pip3 install certifi \
    && pip3 install flask \
    && pip3 install weasyprint \
    && pip3 install uwsgi \
    && update-ms-fonts \
    && fc-cache -f \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/* /tmp/* /root/.cache/pip && find /usr/lib/python3.6 -name '*.pyc' -delete

COPY weasyweb /opt/weasyweb

EXPOSE 4652

CMD [ "uwsgi", "--ini", "/opt/weasyweb/conf/uwsgi.conf" ]