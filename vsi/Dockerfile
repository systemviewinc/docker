# Start with Ubuntu base image
FROM ubuntu:16.04
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

# Install XFCE4, VNC server, XRDP and Vivado
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
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
  tightvncserver \
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
  gcc-multilib

# copy in config file
COPY install_config.txt /

# download and run the install
ARG VIVADO_TAR_HOST
ARG VIVADO_TAR_FILE
ARG VIVADO_VERSION
RUN echo "Downloading ${VIVADO_TAR_FILE} from ${VIVADO_TAR_HOST}" && \
  wget ${VIVADO_TAR_HOST}/${VIVADO_TAR_FILE}.tar.gz -q && \
  echo "Extracting Vivado tar file" && \
  tar xzf ${VIVADO_TAR_FILE}.tar.gz && \
  /${VIVADO_TAR_FILE}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config install_config.txt && \
  rm -rf ${VIVADO_TAR_FILE}*

# create a new user
RUN adduser --disabled-password --gecos '' vivado
USER vivado
WORKDIR /home/vivado
#add vivado tools to path
RUN echo "source /opt/Xilinx/Vivado/${VIVADO_VERSION}/settings64.sh" >> /home/vivado/.bashrc

# copy license file
RUN mkdir /home/vivado/.Xilinx
COPY Xilinx.lic /home/vivado/.Xilinx/

# Set user for VNC server (USER is only for build)
ENV USER root
# Set default password
COPY password.txt .
RUN cat password.txt password.txt | vncpasswd && \
  rm password.txt
# Expose VNC port
EXPOSE 5901

# Set XDRP to use TightVNC port
RUN sed -i '0,/port=-1/{s/port=-1/port=5901/}' /etc/xrdp/xrdp.ini

# Copy VNC script that handles restarts
COPY vnc.sh /opt/
CMD ["/opt/vnc.sh"]
