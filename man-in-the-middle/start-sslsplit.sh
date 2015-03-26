#!/bin/bash

clear; pwd; echo

u=`whoami`

echo "> Are you root?"
if [ ! "$u" = "root" ]; then
	echo "* You need to run this script as root"
	exit 1
fi
echo ">> yes"

echo "> Looking for SSLsplit in the system..."
which sslsplit > /dev/null # check if command exists
if [ $? -ne 0 ]; then
	 echo "* You need to install SSLsplit"
	 exit 2
fi 
echo ">> ok"
echo "> Looking for certificate in directory..."
if [ ! -f ca.crt ]; then
    echo "* Not found. You need to have the certificate 'ca.crt' in the script directoy"
    exit 3
fi
echo ">> ok"

echo "> Looking for private key in directory..."
if [ ! -f ca.key ]; then
   	echo "* Not found. You need to have the private key file 'ca.key' in the script directoy"
    exit 3
fi
echo ">> ok"

echo "> Configuring IPTABLES..."
( iptables -F && \
sysctl -w net.ipv4.ip_forward=1 > /dev/null && \
iptables -t nat -F && \
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080 && \
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-ports 8443 && \
iptables -t nat -A PREROUTING -p tcp --dport 587 -j REDIRECT --to-ports 8443 && \
iptables -t nat -A PREROUTING -p tcp --dport 465 -j REDIRECT --to-ports 8443 && \
iptables -t nat -A PREROUTING -p tcp --dport 993 -j REDIRECT --to-ports 8443 && \
iptables -t nat -A PREROUTING -p tcp --dport 5222 -j REDIRECT --to-ports 808 && \
echo ">> ok" ) || ( echo "* failed!" && exit 4 )

# Directories
mkdir -p /tmp/sslsplit
mkdir -p logs

echo "> Running SSLsplit..."
# SSLsplit command
sslsplit -D -l connections.log -j /tmp/sslsplit -S logs/ -k ca.key -c ca.crt ssl 0.0.0.0 8443 tcp 0.0.0.0 8080

echo
echo ">> Exiting... Look for instructions at http://blog.philippheckel.com/2013/08/04/use-sslsplit-to-transparently-sniff-tls-ssl-connections/"
