FROM java:latest
MAINTAINER 王俊 "wang_j90@126.com"

COPY sources.list /etc/apt/
RUN  apt-get update
RUN apt-get install -y net-tools

COPY ActivationCode.class /ActivationCode.class
COPY start.sh /start.sh

EXPOSE 8080

CMD ["/bin/sh","/start.sh"]