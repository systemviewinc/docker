#!/bin/bash

HOSTNAME=`hostname`

smbclient -L localhost -U%

ret=$?
if [ $ret -ne 0 ];then exit $ret; fi

smbclient //localhost/netlogon -UAdministrator -c 'ls'

ret=$?
if [ $ret -ne 0 ];then exit $ret; fi

host -t SRV _ldap._tcp.corp.systemviewinc.com.

ret=$?
if [ $ret -ne 0 ];then exit $ret; fi

host -t SRV _kerberos._udp.corp.systemviewinc.com.

ret=$?
if [ $ret -ne 0 ];then exit $ret; fi

host -t A ${HOSTNAME}.corp.systemviewinc.com.

ret=$?
if [ $ret -ne 0 ];then exit $ret; fi

kinit administrator

ret=$?
if [ $ret -ne 0 ];then exit $ret; fi

klist

ret=$?
if [ $ret -ne 0 ];then exit $ret; fi
