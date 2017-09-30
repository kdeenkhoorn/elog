FROM cubian.phantasyworld.intern:5000/kdedesign/debian-stretch

MAINTAINER "k.eenkhoorn@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Create user and group account
RUN groupadd -g 2001 elog \
    && useradd -u 2001 -g 2001 -c "elog useraccount" -d /var/lib/elog -s /bin/bash elog

# imagemagick and elog and mailutils
RUN apt-get update \
    && apt-get --yes install \
        openssl \
        imagemagick \
        ckeditor \
        elog \
        mailutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Edit mailsettings for elog
# Configure exim to use smarthost for relay
RUN sed -i -e "s/^dc_eximconfig_configtype=.*$/dc_eximconfig_configtype='satellite'/" \
           -e "s/^dc_readhost=.*$/dc_readhost='elog.phantasyworld.intern'/" \
           -e "s/^dc_smarthost=.*$/dc_smarthost='cubian.phantasyworld.intern'/" \
           -e "s/^dc_hide_mailname=.*$/dc_hide_mailname='true'/" \
           -e "s/^dc_mailname_in_oh=.*$/dc_mailname_in_oh='true'/" \
    /etc/exim4/update-exim4.conf.conf \
    && /usr/sbin/update-exim4.conf \
    && echo "elog.phantasyworld.intern" > /etc/mailname \
    && sed -i 's/DAEMON_OPTS=""/DAEMON_OPTS="-p 8080 -c \/var\/lib\/elog\/elogd.cfg"/' /etc/default/elog


EXPOSE 8080

CMD /etc/init.d/exim4 start ; su elog -c "/usr/sbin/elogd -p 8080 -c /var/lib/elog/elogd.cfg"
