FROM alpine:3.15
MAINTAINER RSTM Team "team@rstm.pw"

ENV MUSL_LOCPATH=/usr/share/i18n/locales/musl
ENV LANG=ru_RU.UTF-8

# v54

RUN apk add --no-cache python3 py3-pip py3-wheel cairo pango jpeg openjpeg libintl gettext \
    && apk add --no-cache --virtual build-dependencies build-base linux-headers pcre-dev python3-dev jpeg-dev openjpeg-dev libffi-dev musl-dev zlib-dev gcc g++ glib msttcorefonts-installer ca-certificates curl cmake gettext-dev \
    && curl -fsSL "https://gitlab.com/rilian-la-te/musl-locales/-/archive/master/musl-locales-master.zip" -o musl-locales-master.zip \
	&& unzip musl-locales-master.zip \
	&& cd musl-locales-master \
	&& cmake -DLOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . \
	&& make \
	&& make install \
	&& cd .. \
	&& rm -r musl-locales-master \
	\
    && pip3 install --upgrade pip \
    && pip3 install certifi \
    && pip3 install flask \
    && pip3 install weasyprint \
    && pip3 install uwsgi \
    && update-ms-fonts \
    && fc-cache -f \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/* /tmp/* /root/.cache/pip && find /usr/lib/python3*/ -name '*.pyc' -delete

COPY weasyweb /opt/weasyweb

EXPOSE 4652

CMD [ "uwsgi", "--ini", "/opt/weasyweb/conf/uwsgi.conf" ]