FROM nginx:latest

RUN    apt-get update -y \
    && apt-get install -y --no-install-recommends apt-utils

COPY ./01-request-certificate-ssl.sh /docker-entrypoint.d/
