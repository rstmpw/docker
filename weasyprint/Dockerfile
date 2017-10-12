FROM alpine:3.6
MAINTAINER RSTM Team "team@rstm.pw"

ENV LANG=ru_RU.UTF-8

RUN apk add --no-cache libxslt python3 python3-dev libffi-dev musl-dev zlib-dev jpeg-dev cairo gcc glib pango msttcorefonts-installer ca-certificates\
    && pip3 install certifi \
    && pip3 install weasyprint \
    && update-ms-fonts \
    && fc-cache -f \
    && rm -rf /var/cache/apk/* /tmp/* /root/.cache/pip && find /usr/lib/python3.6 -name '*.pyc' -delete

ADD xml2pdf /usr/bin/xml2pdf
ADD html2pdf /usr/bin/html2pdf

CMD [ "weasyprint" ]