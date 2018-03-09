FROM cubian.phantasyworld.intern:5000/kdedesign/debian-stretch
MAINTAINER "k.eenkhoorn@gmail.com"

# Upgrade base OS image
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install specific software we need for this image
# imagemagick and elog and mailutils and add user
RUN groupadd -g 2001 elog \
    && useradd -u 2001 -g 2001 -c "elog useraccount" -d /var/lib/elog -s /bin/bash elog \
    && apt-get update \
    && apt-get --no-install-recommends -y install \
       openssl \
       imagemagick \
       ckeditor \
       elog \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8080
USER elog
CMD ["/usr/sbin/elogd", "-p", "8080", "-c", "/var/lib/elog/elogd.cfg"]
