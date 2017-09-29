FROM kdedesign/debian-stretch

MAINTAINER "k.eenkhoorn@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Create user and group account
RUN groupadd -g 2001 elog
RUN useradd -u 2001 -g 2001 -c "elog useraccount" -d /var/lib/elog -s /bin/bash elog


# imagemagick and elog
RUN apt-get update \
    && apt-get --yes install \
        openssl \
        imagemagick \
        ckeditor \
        elog \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get clean

EXPOSE 8080

USER elog
CMD ["elogd", "-p", "8080", "-c", "/var/lib/elog/elogd.cfg"]
