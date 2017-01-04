# Start with Systemview vivado image
FROM systemview/vivado:2016.4
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

ENV USER vsi
USER ${USER}

ARG VSI_VERSION=2016.4
ARG VSI_MINOR_VERSION=1.1
ARG VSI_HOST=http://127.0.0.1
ARG VSI_FILE=vsi_install_V${VSI_VERSION}_Release_${VSI_MINOR_VERSION}

RUN echo " ===> Downloading and extracting VSI image from ${VSI_HOST}/${VSI_FILE}.zip <===" && \
	unzip -qO- ${VSI_HOST}/${VSI_FILE}.tar.gz | tar xz && \
	echo " ===> Installing VSI <===" && \
	sudo bash ${VSI_FILE}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA -b Install -c install_config.txt && \
	echo " ===> VSI Installation Completed <===" && \
	rm -rf ${VSI_FILE}*
