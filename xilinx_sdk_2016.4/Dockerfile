# Start with Systemview ubuntu image
FROM gcr.io/systemviewinc/ubuntu:16.04
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

ENV USER vsi
USER ${USER}

ARG SDK_VERSION=2016.4
ARG SDK_HOST=https://storage.googleapis.com/systemview/xilinx
ARG SDK_FILE=Xilinx_SDK_${SDK_VERSION}

# Install Xilinx SDK
RUN echo " ===> Downloading and extracting SDK image from ${SDK_HOST}/${SDK_FILE}.tar.bz2 <===" && \
	wget -qO- ${SDK_HOST}/${SDK_FILE}.tar.bz2 | tar xj && \
	echo " ===> Installing SDK <===" && \
	sudo bash ${SDK_FILE}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA -b Install -c ${SDK_FILE}/install_config.txt && \
	echo " ===> SDK Installation Completed <===" && \
	rm -rf ${SDK_FILE}*

# add sdk tools to path
RUN echo ". /opt/Xilinx/SDK/${SDK_VERSION}/settings64.sh" >> /home/${USER}/.bashrc

## copy license file
RUN mkdir -p /home/${USER}/.Xilinx
#COPY Xilinx.lic /home/${USER}/.Xilinx/
