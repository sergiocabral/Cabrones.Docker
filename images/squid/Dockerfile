FROM ubuntu:latest

ENV SQUID_CONF_FINAL_DIR=/etc/squid/conf \
    SQUID_CONF_TEMPLATE_DIR=/etc/squid/templates \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y squid \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y gettext-base \
    && rm -rf /var/lib/apt/lists/*

COPY envsubst.sh /envsubst.sh
RUN chmod 755 /envsubst.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
