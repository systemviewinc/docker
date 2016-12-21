# Start with Ubuntu base image
FROM ubuntu:16.04
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

# Install XFCE4, XRDP and assorted tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  sudo \
  fish \
  wget \
  build-essential \
  libglib2.0-0 \
  libsm6 \
  libxi6 \
  libxrender1 \
  libxrandr2 \
  libfreetype6 \
  libfontconfig \
  xfce4 \
  xrdp \
  zlib1g-dev \
  cmake \
  git \
  automake \
  autoconf \
  g++ \
  g++-mingw-w64-x86-64 \
  vim \
  make \
  bison \
  flex \
  gcc-multilib \
  libtasn1-3-bin \
  xfce4-terminal

# install tigervnc
RUN wget https://bintray.com/tigervnc/stable/download_file?file_path=ubuntu-16.04LTS%2Famd64%2Ftigervncserver_1.7.0-1ubuntu1_amd64.deb -O tigervncserver_1.7.0-1ubuntu1_amd64.deb && dpkg -i tigervncserver_1.7.0-1ubuntu1_amd64.deb && apt install -f

# Set user for VNC server (USER is only for build)
ENV USER root

# Set XDRP to use TightVNC port
RUN sed -i '0,/port=-1/{s/port=-1/port=5901/}' /etc/xrdp/xrdp.ini

ENV USER vivado
# create a new user
RUN useradd -m ${USER} -s /bin/bash -G sudo
COPY password.txt .

# set password
RUN echo -n ${USER}: | cat - password.txt | chpasswd && rm password.txt
RUN echo "${USER}    ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
USER ${USER}
WORKDIR /home/${USER}

ARG VIVADO_VERSION

# add vivado tools to path
RUN echo "#. /opt/Xilinx/Vivado/${VIVADO_VERSION}/settings64.sh" >> /home/${USER}/.bashrc

## copy license file
RUN mkdir /home/${USER}/.Xilinx
#COPY Xilinx.lic /home/${USER}/.Xilinx/

# Copy VNC script that handles restarts
COPY vnc.sh /opt/

# vnc config
RUN mkdir -p /home/${USER}/.vnc
COPY xstartup /home/${USER}/.vnc

# Expose VNC port
EXPOSE 5901

# Set default password
COPY password.txt .
RUN cat password.txt password.txt | vncpasswd && rm password.txt

# finally start vncserver
CMD ["/opt/vnc.sh"]
