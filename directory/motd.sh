#!/bin/bash

figlet -w 100 -f small -c SVI Directory Server $1 > /tmp/motd
echo "SystemView Infrastructure Docs:  https://systemviewinc.com/infra" >> /tmp/motd
sudo mv /tmp/motd /etc/motd
