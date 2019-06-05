FROM jonazpiazu/libfreenect2_cuda_8

ENV ROS_DISTRO indigo
WORKDIR /root/ws

RUN apt-get update -qq && \
    apt-get -qq install --no-install-recommends -y apt-utils wget ca-certificates sudo

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
        ros-${ROS_DISTRO}-catkin

RUN mkdir src && \
  cd src && \
  git clone https://github.com/code-iai/iai_kinect2.git

RUN apt-get update && \
    rosdep init && \
    rosdep update --include-eol-distros && \
    rosdep install -y \
      --from-paths src \
      --ignore-src \
      --rosdistro ${ROS_DISTRO} \
      --as-root=apt:false && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN catkin config --extend /opt/ros/$ROS_DISTRO --install --install-space /opt/ros/$ROS_DISTRO && \
  catkin build
