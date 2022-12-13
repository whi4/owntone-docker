#!/bin/bash

sed -i 's/#	admin_password = ""/	admin_password = "'$OWNTONE_PASSWORD'"/' /etc/owntone.conf
/etc/init.d/dbus start
/etc/init.d/avahi-daemon start

usermod -u $OWNTONE_UID owntone
groupmod -g $OWNTONE_GID owntone

touch /var/log/owntone.log && chown owntone:owntone /var/log/owntone.log && chmod g+rw /var/log/owntone.log
chown -R owntone:owntone /var/cache/owntone && chmod -R g+rw /var/cache/owntone

su owntone -c '/usr/sbin/owntone -f' -s /bin/bash