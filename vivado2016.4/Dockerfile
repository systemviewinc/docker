# Start with Systemview xilinx_sdk image
FROM systemview/xilinx_sdk:2016.4
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

ENV USER vsi
USER ${USER}

ARG VIVADO_VERSION=2016.4
ARG VIVADO_MINOR_VERSION=1215_1
ARG VIVADO_HOST=http://127.0.0.1
ARG VIVADO_FILE=Xilinx_Vivado_SDK_${VIVADO_VERSION}_${VIVADO_MINOR_VERSION}

# Install Xilinx SDK
COPY install_config.txt .
RUN echo " ===> Downloading and extracting Vivado image from ${VIVADO_HOST}/${VIVADO_FILE}.tar.gz <===" && \
	wget -qO- ${VIVADO_HOST}/${VIVADO_FILE}.tar.gz | tar xz && \
	echo " ===> Installing Vivado <===" && \
	sudo bash ${VIVADO_FILE}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA -b Install -c install_config.txt && \
	echo " ===> Vivado Installation Completed <===" && \
	rm -rf ${VIVADO_FILE}* install_config.txt

# add vivado tools to path
RUN echo ". /opt/Xilinx/Vivado/${VIVADO_VERSION}/settings64.sh" >> /home/${USER}/.bashrc

# disable GTK3, required to run xsdk
RUN echo "export SWT_GTK3=0" >> /home/${USER}/.bashrc

# install cable drivers
RUN echo " ===> Install Cable Drivers <===" && \
	cd /opt/Xilinx/Vivado/2016.4/data/xicom/cable_drivers/lin64/install_script/install_drivers && \
	sudo ./install_drivers

## copy license file
RUN mkdir -p /home/${USER}/.Xilinx
#COPY Xilinx.lic /home/${USER}/.Xilinx/
