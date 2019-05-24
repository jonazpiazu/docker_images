ARG ONEDRIVE_VERSION=1.3.1
FROM ubuntu:bionic

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PUID 1000
ENV PGID 1000

WORKDIR /root/ws

# install requirements
RUN apt-get -qq update &&  apt install --no-install-recommends -q -y \
    libcurl4-openssl-dev libsqlite3-dev curl gnupg2 xz-utils git build-essential ca-certificates \
    && curl -fsS https://dlang.org/install.sh | bash -s dmd \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/skilion/onedrive.git \
    && cd onedrive \
    && git checkout ${ONEDRIVE_VERSION} \
    && /bin/bash -c "source  ~/dlang/dmd-2.086.0/activate && make" \
    && make install \
    && cd .. \
    && rm -rf onedrive

RUN addgroup --gid 1000 dockerusers \
    && useradd -u 1000 -g 1000 dockeruser

WORKDIR /home/dockeruser

USER dockeruser

VOLUME /config /onedrive

ENTRYPOINT [ "/usr/local/bin/onedrive","--confdir","/config","--syncdir","/onedrive"]
# CMD ["bash"]
