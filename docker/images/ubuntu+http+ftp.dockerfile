# Servidor Linux Ubuntu com Apache HTTP Server

# Imagem base: Linux Ubuntu.
FROM ubuntu:latest

# Labels.
LABEL maintainer="sergio@cabral.br.com"

# Variáveis de ambiente disponíveis no contexto do build.
ARG SUFFIX=""
ARG TZ=""
ARG HTTP_EMAIL=""
ARG HTTP_DOMAIN=""
ARG FTP_USER=""
ARG FTP_PASSWORD=""

# Linux Ubuntu.
COPY ./scripts/ubuntu /root/scripts/ubuntu
WORKDIR /root/scripts/ubuntu
RUN /root/scripts/ubuntu/run.sh

# Apache HTTP Server.
COPY ./scripts/apache2 /root/scripts/apache2
WORKDIR /root/scripts/apache2
RUN /root/scripts/apache2/run.sh

# Certificado HTTPS/SSL
COPY ./scripts/certbot /root/scripts/certbot
WORKDIR /root/scripts/certbot
RUN /root/scripts/certbot/run.sh

# PHP.
COPY ./scripts/php /root/scripts/php
WORKDIR /root/scripts/php
RUN /root/scripts/php/run.sh

# pdo_sqlsrv.
COPY ./scripts/pdo_sqlsrv /root/scripts/pdo_sqlsrv
WORKDIR /root/scripts/pdo_sqlsrv
RUN /root/scripts/pdo_sqlsrv/run.sh

# vsftpd FTP Server.
COPY ./scripts/vsftpd /root/scripts/vsftpd
WORKDIR /root/scripts/vsftpd
RUN /root/scripts/vsftpd/run.sh

# Liberação de portas de rede.
EXPOSE 80/tcp
EXPOSE 443/tcp
EXPOSE 20-21
EXPOSE 21100-21110

# Caminho inicial.
WORKDIR /root

# Comando a executar quando rodar a imagem.
ENTRYPOINT [ "supervisord", "-c", "/etc/supervisor.conf" ]
