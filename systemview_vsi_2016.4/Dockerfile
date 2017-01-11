# Start with Systemview vivado image
FROM gcr.io/systemviewinc/vivado:2016.4
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

ENV USER vsi
USER ${USER}

ARG VSI_VERSION=2016.4
ARG VSI_MINOR_VERSION=1.1
ARG VSI_HOST=http://127.0.0.1
ARG VSI_FILE=systemview_vsi_${VSI_VERSION}_${VSI_MINOR_VERSION}

RUN echo " ===> Downloading and extracting VSI image from ${VSI_HOST}/${VSI_FILE}.tar.bz2 <===" && \
	sudo mkdir -p /opt/Systemview/VSI/${VSI_VERSION} && \
	cd /opt/Systemview/VSI/${VSI_VERSION} && \
	echo " ===> Downloading VSI <===" && \
	wget -qO- ${VSI_HOST}/${VSI_FILE}.tar.bz2 | sudo tar xjm && \
	echo " ===> VSI Installation Completed <==="

RUN echo "export VSI_INSTALL=\${VSI_INSTALL:-/opt/Systemview/VSI/${VSI_VERSION}}\nexport PATH=\${VSI_INSTALL}/host/linux.x86_64/bin:\$PATH" >> /home/${USER}/.bashrc
