FROM debian:latest

RUN apt-get update

# Install Debian base components for owntone to work
RUN apt-get -y install systemd
RUN apt-get -y install systemd-sysv
RUN apt-get -y install avahi-daemon

# Install owntone base dependencies
RUN apt-get -y install \
  build-essential git autotools-dev autoconf automake libtool gettext gawk \
  gperf bison flex libconfuse-dev libunistring-dev libsqlite3-dev \
  libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev \
  libasound2-dev libmxml-dev libgcrypt20-dev libavahi-client-dev zlib1g-dev \
  libevent-dev libplist-dev libsodium-dev libjson-c-dev libwebsockets-dev \
  libcurl4-openssl-dev libprotobuf-c-dev libxml2-dev

# Install owntone extra deps for Chromecast
RUN apt-get -y install \
  libgnutls28-dev

RUN git clone https://github.com/owntone/owntone-server.git && \ 
  cd owntone-server && \
  autoreconf -i && \
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-install-user --enable-chromecast && \
  make && make install

RUN touch /var/log/owntone.log && chown owntone:owntone /var/log/owntone.log && chmod g+rw /var/log/owntone.log
RUN chown -R owntone:owntone /var/cache/owntone && chmod g+rw /var/cache/owntone
RUN echo "net.ipv4.ip_unpriviledged_port_start=0" > /etc/sysctl.d/50-owntone.conf
 
COPY entrypoint.sh /scripts/entrypoint.sh
RUN [ "chmod", "+x", "/scripts/entrypoint.sh" ]
ENTRYPOINT [ "/scripts/entrypoint.sh" ]
