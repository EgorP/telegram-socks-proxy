FROM ubuntu:bionic

RUN apt-get update
RUN apt-get install -y dante-server dnsutils
COPY danted.conf /etc/danted.conf
CMD danted

RUN export MYIP="$(dig +short myip.opendns.com @resolver1.opendns.com)" && \
    export  PROXY_PASSWD="$(perl -le 'print map { (a..z,A..Z,0..9)[rand 62] } 0..pop' 16)" && \
    echo "proxy:${PROXY_PASSWD}" | chpasswd && \
    echo "==========\nPaste in telegram and click link below:\n\ntg://socks?server=$MYIP&port=1080&user=proxy&pass=${PROXY_PASSWD}\n\n=========="
