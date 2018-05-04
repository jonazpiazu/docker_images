ARG CUDA_VERSION=8.0
FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu14.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ENV HOME /root
WORKDIR ${HOME}/src
ENV ROS_DISTRO indigo

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

RUN echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list
RUN apt-key adv --keyserver "hkp://ha.pool.sks-keyservers.net" --recv-key "0xB01FA116" \
    || { wget "https://raw.githubusercontent.com/ros/rosdistro/master/ros.key" -O - | sudo apt-key add -; }

RUN sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list && \
    apt-get update -qq && \
    apt-get -qq install --no-install-recommends -y \
        ros-${ROS_DISTRO}-ros-base \
        build-essential \
        python-catkin-tools \
        python-pip \
        python-rosdep \
        python-wstool \
        ros-${ROS_DISTRO}-catkin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        pkg-config \
        libxau-dev \
        libxdmcp-dev \
        libxcb1-dev \
        libxext-dev \
        libx11-dev && \
    rm -rf /var/lib/apt/lists/*

COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
  /usr/local/lib/x86_64-linux-gnu \
  /usr/local/lib/x86_64-linux-gnu

COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
  /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json \
  /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json

RUN echo '/usr/local/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
    ldconfig && \
    echo '/usr/local/$LIB/libGL.so.1' >> /etc/ld.so.preload && \
    echo '/usr/local/$LIB/libEGL.so.1' >> /etc/ld.so.preload

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
