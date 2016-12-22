# Start with Systemview ubuntu image
FROM systemview/ubuntu:16.04
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

ENV USER vivado
USER ${USER}

ARG SDK_VERSION=2016.4
ARG SDK_HOST=http://127.0.0.1
ARG SDK_FILE=Xilinx_SDK_${SDK_VERSION}

# Install Xilinx SDK
RUN echo "== Downloading SDK image from ${SDK_HOST}/${SDK_FILE}.tar.bz2 ==" && \
	wget -q ${SDK_HOST}/${SDK_FILE}.tar.bz2 && \
	echo "== Extracting SDK Image ==" && \
	tar xf ${SDK_FILE}.tar.bz2 && cd ${SDK_FILE} && \
	echo "== Installing SDK ==" && \
	echo sudo bash xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA -b Install -c install_config.txt && \
	echo "== SDK Installation Completed =="

# add sdk tools to path
RUN echo ". /opt/Xilinx/SDK/${SDK_VERSION}/settings64.sh" >> /home/${USER}/.bashrc

## copy license file
RUN mkdir /home/${USER}/.Xilinx
#COPY Xilinx.lic /home/${USER}/.Xilinx/
