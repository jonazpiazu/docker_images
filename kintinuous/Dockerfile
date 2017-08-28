FROM jonazpiazu/cuda_pcl_opencv

WORKDIR ${HOME}/src

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -qq && \
    apt-get -qq install -y libusb-1.0-0-dev libudev-dev openjdk-7-jdk libsuitesparse-dev

RUN mkdir deps

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
