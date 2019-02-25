FROM ubuntu:16.04
ENV	DEBIAN_FRONTEND=noninteractive
ENV TINI_SHA1="d1cb5d71adc01d47e302ea439d70c79bd0864288"
ENV TINI_URL="https://github.com/krallin/tini/releases/download/v0.16.1/tini-static-amd64"
RUN	apt-get -y update \
	&& apt-get -y upgrade \
	&& apt-get -y install rsyslog rsyslog-gnutls coreutils wget \
    && wget -nv -O /usr/local/bin/tini $TINI_URL && echo "$TINI_SHA1 /usr/local/bin/tini" | sha1sum -c \
    && chmod a+rx /usr/local/bin/tini \
    && apt-get -y autoremove wget \
    && apt-get -y clean \
    && rm -rf /var/cache/ \
	&& rm /etc/rsyslog.conf


ADD	rsyslog.conf /etc/rsyslog.conf
ADD papertrail-bundle.pem /etc/ssl/papertrail-bundle.pem
ADD start.sh /start.sh

RUN chmod a+rx /start.sh

EXPOSE 514

CMD	["/usr/local/bin/tini", "/start.sh"]
