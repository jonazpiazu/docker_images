FROM resin/rpi-raspbian

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/Library/Application Support" \
PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver" \
PLEX_MEDIA_SERVER_INFO_DEVICE=docker \
PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="6" \
PLEX_MEDIA_SERVER_USER=root \
LD_LIBRARY_PATH=/usr/lib/plexmediaserver/

#install packages
RUN apt-get -qq update && \
 	apt-get -qq install -y \
	avahi-daemon \
	dbus \
	unrar-free \
	wget \
	git \
	fakeroot \
	apt-transport-https

# install plex
RUN wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key | apt-key add - && \
    echo "deb https://dev2day.de/pms/ jessie main" >> /etc/apt/sources.list.d/pms.list && \
    apt-get -qq update && \
    apt-get -qq install -y plexmediaserver-installer 
    
# cleanup
RUN apt-get clean && \
  rm -rf \
  /etc/default/plexmediaserver \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

# add local files
COPY root/ /

#exports and volumes
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
VOLUME /config /transcode
ENTRYPOINT []
CMD ["/usr/lib/plexmediaserver/Plex Media Server"]
