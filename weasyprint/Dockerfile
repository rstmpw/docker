#FROM python:alpine3.6
FROM alpine:3.6
MAINTAINER RSTM Team "team@rstm.pw"

ENV LANG=ru_RU.UTF-8

RUN apk add --no-cache python3 python3-dev libffi-dev musl-dev zlib-dev jpeg-dev cairo gcc glib pango msttcorefonts-installer ca-certificates\
    && pip3 install certifi \
    && pip3 install weasyprint \
    && update-ms-fonts \
    && fc-cache -f

CMD [ "weasyprint" ]