# Servidor Linux Ubuntu com MariaDB.

# Imagem base: Linux Ubuntu.
FROM ubuntu:latest

# Labels
LABEL maintainer="sergio@cabral.br.com"

# Variáveis de ambiente disponíveis no contexto do build.
ARG SUFFIX=""
ARG TZ=""
ARG MYSQL_ROOT_USER=""
ARG MYSQL_ROOT_HOST=""
ARG MYSQL_ROOT_PASSWORD=""

# Linux Ubuntu.
COPY ./scripts/ubuntu /root/scripts/ubuntu
WORKDIR /root/scripts/ubuntu
RUN /root/scripts/ubuntu/run.sh

# MariaDB.
COPY ./scripts/mariadb /root/scripts/mariadb
WORKDIR /root/scripts/mariadb
RUN /root/scripts/mariadb/run.sh

# Liberação de portas de rede.
EXPOSE 3306/tcp

# Caminho inicial.
WORKDIR /root

# Comando a executar quando rodar a imagem.
ENTRYPOINT [ "supervisord", "-c", "/etc/supervisor.conf" ]
