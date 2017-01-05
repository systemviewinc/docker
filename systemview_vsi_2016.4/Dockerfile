# Start with Systemview vivado image
FROM systemview/vivado:2016.4
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

ENV USER vsi
USER ${USER}

ARG VSI_VERSION=2016.3
ARG VSI_MINOR_VERSION=1.1
ARG VSI_HOST=http://127.0.0.1
ARG VSI_FILE=systemview_vsi_${VSI_VERSION}_${VSI_MINOR_VERSION}

RUN echo " ===> Downloading and extracting VSI image from ${VSI_HOST}/${VSI_FILE}.zip <===" && \
	echo " ===> Downloading VSI <===" && \
	wget -q ${VSI_HOST}/${VSI_FILE}.zip && \
	echo " ===> Installing VSI <===" && \
	sudo mkdir -p /opt/Systemview/VSI/${VSI_VERSION} && \
	sudo unzip -q ${VSI_HOST}/${VSI_FILE}.zip -d /opt/Systemview/VSI/${VSI_VERSION}/ && \
	echo " ===> VSI Installation Completed <===" && \
	rm -rf ${VSI_FILE}*

RUN echo "export PATH=/opt/Systemview/VSI/${VIVADO_VERSION}/host/linux.x86_64/bin:$PATH" >> /home/${USER}/.bashrc
