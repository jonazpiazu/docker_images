FROM nvidia/cuda:8.0-devel-ubuntu14.04

WORKDIR ${HOME}/src

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -qq && \
    apt-get -qq install --no-install-recommends -y apt-utils wget ca-certificates sudo build-essential cmake git software-properties-common

RUN apt-get -qq install -y libusb-1.0-0-dev libudev-dev openjdk-7-jdk freeglut3-dev python-vtk libvtk-java libglew-dev libsuitesparse-dev unzip

RUN mkdir deps

## PCL
RUN add-apt-repository -y ppa:v-launchpad-jochen-sprickerhof-de/pcl && \
  apt-get update -qq && \
  apt-get -qq install -y libpcl-all && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

## Pangolin
RUN cd deps && \
  git clone https://github.com/stevenlovegrove/Pangolin.git && \
  mkdir -p Pangolin/build && \
  cd Pangolin/build && \
  cmake ../ -DAVFORMAT_INCLUDE_DIR="" && \
  make -j8 && \
  make install && \
  cd ../.. && \
  rm -rf Pangolin

#Building OpenCV from scratch without Qt and with nonfree
RUN  cd deps && \
  wget -q http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.9/opencv-2.4.9.zip && \
  unzip -q opencv-2.4.9.zip && \
  rm opencv-2.4.9.zip && \
  mkdir -p opencv-2.4.9/build && \
  cd opencv-2.4.9/build && \
  cmake -D BUILD_NEW_PYTHON_SUPPORT=OFF -D WITH_OPENCL=OFF -D WITH_OPENMP=ON -D INSTALL_C_EXAMPLES=OFF -D BUILD_DOCS=OFF -D BUILD_EXAMPLES=OFF -D WITH_QT=OFF -D WITH_OPENGL=OFF -D WITH_VTK=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_TESTS=OFF -D WITH_CUDA=OFF -D BUILD_opencv_gpu=OFF .. && \
  make -j8 && \
  make install && \
  echo "/usr/local/lib" |  tee -a /etc/ld.so.conf.d/opencv.conf && \
  ldconfig && \
  echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig" | tee -a /etc/bash.bashrc && \
  echo "export PKG_CONFIG_PATH" | tee -a /etc/bash.bashrc && \
  cd ../.. && \
  rm -rf opencv-2.4.9

  #DLib for place recognition
RUN cd deps && \
  git clone https://github.com/dorian3d/DLib.git && \
  cd DLib && \
  git reset --hard 330bdc10576f6bcb55e0bd85cd5296f39ba8811a && \
  mkdir build && \
  cd build && \
  cmake ../ && \
  make -j8 && \
  make install && \
  cd ../.. && \
  rm -rf DLib

  #DBoW2 for place recognition
RUN cd deps && \
  git clone https://github.com/dorian3d/DBoW2.git && \
  cd DBoW2 && \
  git reset --hard 4a6eed2b3ae35ed6837c8ba226b55b30faaf419d && \
  mkdir build && \
  cd build && \
  cmake ../ && \
  make -j8 && \
  make install && \
  cd ../.. && \
  rm -rf DBoW2

  #DLoopDetector for place recognition
RUN cd deps && \
  git clone https://github.com/dorian3d/DLoopDetector.git && \
  cd DLoopDetector && \
  git reset --hard 84bfc56320371bed97cab8aad3aa9561ca931d3f && \
  mkdir build && \
  cd build && \
  cmake ../ && \
  make -j8 && \
  make install && \
  cd ../.. && \
  rm -rf DLoopDetector

  #iSAM for pose graph optimisation
RUN cd deps && \
  wget -q http://people.csail.mit.edu/kaess/isam/isam_v1_7.tgz && \
  tar -xvf isam_v1_7.tgz > /dev/null && \
  rm isam_v1_7.tgz && \
  cd isam_v1_7 && \
  mkdir build && \
  cd build && \
  cmake .. && \
  make -j8 && \
  make install && \
  cd ../.. && \
  rm -rf isam_v1_7

RUN git clone https://github.com/jonazpiazu/Kintinuous.git && \
  mkdir Kintinuous/src/build && \
  cd Kintinuous/src/build/ && \
  cmake .. && \
  make -j8

ENTRYPOINT Kintinuous/src/build/Kintinuous
