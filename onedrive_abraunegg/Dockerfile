ARG UBUNTU_VERSION=xenial
FROM ubuntu:${UBUNTU_VERSION}

ARG ONEDRIVE_VERSION=2.3.3

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /root/ws

# install requirements
RUN apt-get -qq update &&  apt-get install --no-install-recommends -q -y \
    libcurl4-openssl-dev libsqlite3-dev curl gnupg2 xz-utils git build-essential ca-certificates checkinstall \
    && curl -fsS https://dlang.org/install.sh | bash -s dmd \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --single-branch -b v${ONEDRIVE_VERSION} https://github.com/abraunegg/onedrive.git \
    && cd onedrive \
    && /bin/bash -c "source $(find ~/dlang -name "activate") && make" \
    && checkinstall -D -y --pkgname onedrive --pkgversion=2.3.3 --nodoc \
    && mkdir -p /shared \
    && mv onedrive*.deb /shared \
    && cd .. \
    && rm -rf onedrive

