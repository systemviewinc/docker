# Start with Systemview ubuntu image
FROM systemview/ubuntu:16.04
MAINTAINER Adnan Yunus <adnan@systemviewinc.com>

ENV USER vivado
USER ${USER}

# Install Xilinx SDK
ENV SDK_FILE Xilinx_SDK_2016.4
COPY ${SDK_FILE}.tar.bz2 .
RUN tar xf ${SDK_FILE}.tar.bz2 && cd ${SDK_FILE} && sudo bash xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA -b Install -c install_config.txt
