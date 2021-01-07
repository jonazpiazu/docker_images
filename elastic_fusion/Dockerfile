FROM jonazpiazu/ros_kinetic_cuda_dev2

ENV HOME /root
WORKDIR ${HOME}/src

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -qq && \
    apt-get -qq install --no-install-recommends -y \
      apt-utils \
      wget \
      ca-certificates \
      build-essential \
      cmake \
      git \
      software-properties-common \
      pkg-config && \
      add-apt-repository -y ppa:openjdk-r/ppa && \
      apt-get update -qq && \
      apt-get install -qq -y cmake-qt-gui git build-essential libusb-1.0-0-dev libudev-dev openjdk-7-jdk freeglut3-dev libglew-dev libsuitesparse-dev libeigen3-dev zlib1g-dev libjpeg-dev && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*

RUN echo "/usr/local/lib" >> /etc/ld.so.conf.d/local.conf && \
  ldconfig

RUN git clone https://github.com/mp3guy/ElasticFusion.git

RUN cd ElasticFusion && \
  #Installing Pangolin
  git clone https://github.com/stevenlovegrove/Pangolin.git && \
  cd Pangolin && \
  mkdir build && \
  cd build && \
  cmake ../ -DAVFORMAT_INCLUDE_DIR="" -DCPP11_NO_BOOST=ON && \
  make -j8 && \
  make install

RUN cd ElasticFusion && \
  #Up to date OpenNI2
  git clone https://github.com/occipital/OpenNI2.git && \
  cd OpenNI2 && \
  make -j8 && \
  cp Bin/x64-Release/libOpenNI2.so /usr/local/lib && \
  cp -vr Bin/x64-Release/OpenNI2 /usr/local/lib && \
  ldconfig

  #Actually build ElasticFusion
RUN cd ElasticFusion/Core && \
  mkdir build && \
  cd build && \
  cmake ../src && \
  make -j8 && \
  make install && \
  cd ../../GPUTest && \
  mkdir build && \
  cd build && \
  cmake ../src && \
  make -j8 && \
  cd ../../GUI && \
  mkdir build && \
  cd build && \
  cmake ../src && \
  make -j8 && \
  make install && \
  ldconfig

ENTRYPOINT ["ElasticFusion"]
