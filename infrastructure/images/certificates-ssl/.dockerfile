# Servidor Linux Ubuntu com Apache HTTP Server

FROM nginx:latest

EXPOSE 80/tcp

WORKDIR /root

COPY ./*.sh /root/

RUN /root/configure.sh

ENTRYPOINT [ "/root/entrypoint.sh" ]
