FROM alpine 

RUN apk add ansible gcc python3-dev python3-pip libc-dev libffi-dev openssl-dev
RUN pip3 install --upgrade paramiko
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]