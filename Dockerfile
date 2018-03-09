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
       procps \
       openssl \
       imagemagick \
       ckeditor \
       elog \
       mailutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i -e "s/^dc_eximconfig_configtype=.*$/dc_eximconfig_configtype='satellite'/" \
           -e "s/^dc_readhost=.*$/dc_readhost='elog.phantasyworld.intern'/" \
           -e "s/^dc_smarthost=.*$/dc_smarthost='cubian.phantasyworld.intern'/" \
           -e "s/^dc_hide_mailname=.*$/dc_hide_mailname='true'/" \
           -e "s/^dc_mailname_in_oh=.*$/dc_mailname_in_oh='true'/" \
    /etc/exim4/update-exim4.conf.conf \
    && /usr/sbin/update-exim4.conf \
    && echo "elog.phantasyworld.intern" > /etc/mailname \
    && echo "CONFFILE=/var/lib/elog/elogd.cfg" >> /etc/default/elog \
    && echo "PORT=8080" >> /etc/default/elog

COPY my_wrapper_script.sh /opt/my_wrapper_script.sh

EXPOSE 8080

CMD ["/opt/my_wrapper_script.sh"]
