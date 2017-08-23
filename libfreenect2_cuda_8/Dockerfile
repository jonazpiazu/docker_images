FROM nvidia/cuda:8.0-devel-ubuntu14.04

ENV HOME /root
WORKDIR ${HOME}/src

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -qq && \
    apt-get -qq install --no-install-recommends -y \
      apt-utils \
      wget \
      ca-certificates \
      sudo \
      build-essential \
      cmake \
      git \
      software-properties-common \
      pkg-config

RUN git clone https://github.com/OpenKinect/libfreenect2.git

RUN cd libfreenect2/depends && \
  ./download_debs_trusty.sh

RUN dpkg -i libfreenect2/depends/debs/libusb*deb && \
  apt-get -qq install --no-install-recommends -y libturbojpeg libjpeg-turbo8-dev && \
  dpkg -i libfreenect2/depends/debs/libglfw3*deb > /dev/null 2>&1 ; \
  apt-get install -f -y -qq && \
  apt-get -qq install --no-install-recommends -y libgl1-mesa-dri-lts-vivid && \
  apt-add-repository -y ppa:floe/beignet && \
  apt-get update -qq && \
  apt-get -qq install --no-install-recommends -y beignet-dev && \
  dpkg -i libfreenect2/depends/debs/ocl-icd*deb

RUN apt-get -qq install -y cuda-samples-8-0

RUN mkdir -p libfreenect2/build && \
  cd libfreenect2/build && \
  cmake .. && \
  make
