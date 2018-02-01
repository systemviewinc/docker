#!/bin/bash

sed -i 's/\(services\s\+=\)[^\n]*/\1 nss, pam, sudo, autofs/g' /etc/sssd/sssd.conf

echo 'autofs_provider = ad' >> /etc/sssd/sssd.conf
