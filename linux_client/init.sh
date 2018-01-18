#!/bin/bash

mv /tmp/smb.conf /etc/samba/

mv /tmp/krb5.conf /etc/

mv /tmp/ntp.conf /etc/

mv /tmp/realmd.conf /etc/

mv /tmp/sssd.conf /etc/sssd/
chmod 600 /etc/sssd/sssd.conf
chown root:root /etc/sssd/sssd.conf

hostnamectl set-hostname $1

chmod 664 /home/nan/.ssh/authorized_keys
chown nan:nan /home/nan/.ssh/authorized_keys

exit 0
