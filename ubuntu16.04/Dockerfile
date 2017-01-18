# Start with Ubuntu base image
FROM ubuntu:16.04
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

ARG VNC_PACKAGE=tigervncserver_1.7.0-1ubuntu1_amd64.deb

# Install XFCE4, XRDP and assorted tools
RUN apt-get update && \
  apt-get upgrade -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  sudo \
  wget \
  build-essential \
  libglib2.0-0 \
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
  libpixman-1-0 \
  x11-utils \
  libglu1-mesa \
  libsm6 \
  libxi6 \
  libxrender1 \
  libxrandr2 \
  libfreetype6 \
  libfontconfig \
  xrdp \
  xfce4 \
  xfce4-terminal \
  python3-pip \
  openssh-server \
  fish

RUN apt-get remove -y vnc4server \
  xscreensaver \
  pulseaudio && \
  apt-get upgrade -y && \
  apt-get autoremove -y && \
  echo " ===> Installing tigerVNC <===" && \
  wget -q https://bintray.com/tigervnc/stable/download_file?file_path=ubuntu-16.04LTS%2Famd64%2F${VNC_PACKAGE} -O ${VNC_PACKAGE} && \
  dpkg -i tigervncserver_1.7.0-1ubuntu1_amd64.deb && \
  apt install -f && \
  rm ${VNC_PACKAGE}

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir /var/run/sshd

# Set user for VNC server (USER is only for build)
ENV USER root

# Set XDRP to use TightVNC port
RUN sed -i '0,/port=-1/{s/port=-1/port=5901/}' /etc/xrdp/xrdp.ini

ENV USER vsi
# create a new user
RUN useradd -m ${USER} -s /bin/bash -G sudo
COPY password.txt .

# set password
RUN echo -n ${USER}: | cat - password.txt | chpasswd && rm password.txt
RUN echo "${USER}    ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
USER ${USER}
WORKDIR /home/${USER}

# expose SSH port
EXPOSE 22

# Copy remote script to restart sshd and run VNC
COPY remote.sh /opt/

# vnc config
RUN mkdir -p /home/${USER}/.vnc
COPY xstartup /home/${USER}/.vnc

# Expose VNC port
EXPOSE 5901

# Set default password
COPY password.txt .
RUN cat password.txt password.txt | vncpasswd && rm password.txt

# finally start remote script
CMD ["/opt/remote.sh"]
