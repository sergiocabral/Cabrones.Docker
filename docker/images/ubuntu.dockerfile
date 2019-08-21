# Servidor Linux Ubuntu.

# Imagem base: Linux Ubuntu.
FROM ubuntu:latest

# Labels.
LABEL maintainer="sergio@cabral.br.com"

# Variáveis de ambiente disponíveis no contexto do build.
ARG SUFFIX="##########   "
ARG TZ=""

# Linux Ubuntu.
COPY ./scripts/ubuntu /root/scripts/ubuntu
WORKDIR /root/scripts/ubuntu
RUN /root/scripts/ubuntu/run.sh

# Caminho inicial.
WORKDIR /root

# Comando a executar quando rodar a imagem.
ENTRYPOINT [ "supervisord", "-c", "/etc/supervisor.conf" ]
