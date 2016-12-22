# Start with Systemview xilinx_sdk image
FROM systemview/xilinx_sdk:2016.4
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

ENV USER vivado
USER ${USER}

ARG VIVADO_VERSION=2016.4
ARG VIVADO_MINOR_VERSION=1215_1
ARG VIVADO_HOST=http://127.0.0.1
ARG VIVADO_FILE=Xilinx_Vivado_SDK_${VIVADO_VERSION}_${VIVADO_MINOR_VERSION}

# Install Xilinx SDK
COPY install_config.txt .
RUN echo " ===> Downloading Vivado image from ${VIVADO_HOST}/${VIVADO_FILE}.tar.gz <===" && \
	wget -q ${VIVADO_HOST}/${VIVADO_FILE}.tar.gz && \
	echo " ===> Extracting Vivado Image <===" && \
	tar xf ${VIVADO_FILE}.tar.gz && \
	echo " ===> Installing Vivado <===" && \
	sudo bash ${VIVADO_FILE}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA -b Install -c install_config.txt && \
	echo " ===> Vivado Installation Completed <===" && \
	rm -rf ${VIVADO_FILE}*

# add vivado tools to path
RUN echo ". /opt/Xilinx/VIVADO/${VIVADO_VERSION}/settings64.sh" >> /home/${USER}/.bashrc

## copy license file
RUN mkdir -p /home/${USER}/.Xilinx
#COPY Xilinx.lic /home/${USER}/.Xilinx/
