#!/bin/bash
set -e;

create_conf_template_dir() {
    mkdir -p ${SQUID_CONF_TEMPLATE_DIR};
    chmod -R 755 ${SQUID_CONF_TEMPLATE_DIR};
    chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_CONF_TEMPLATE_DIR};
}

create_conf_final_dir() {
    mkdir -p ${SQUID_CONF_FINAL_DIR};
    chmod -R 755 ${SQUID_CONF_FINAL_DIR};
    chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_CONF_FINAL_DIR};
}

create_log_dir() {
    mkdir -p ${SQUID_LOG_DIR};
    chmod -R 755 ${SQUID_LOG_DIR};
    chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_LOG_DIR};
}

create_cache_dir() {
    mkdir -p ${SQUID_CACHE_DIR};
    chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_CACHE_DIR};
}

create_conf_template_dir;
create_conf_final_dir;
create_log_dir;
create_cache_dir;

cd /etc/squid;
/envsubst.sh;

# allow arguments to be passed to squid
if [[ ${1:0:1} = '-' ]];
then

    EXTRA_ARGS="$@";
    set --;

elif [[ ${1} == squid || ${1} == $(which squid) ]];
then

    EXTRA_ARGS="${@:2}";
    set --;

fi

# default behaviour is to launch squid
if [[ -z ${1} ]];
then

    if [[ ! -d ${SQUID_CACHE_DIR}/00 ]];
    then

        printf "Initializing cache...\n";
        $(which squid) -N -f /etc/squid/squid.conf -z;

        mv /etc/squid/squid.conf /etc/squid/squid.conf.original;

    fi

    if [[ ! -e "$SQUID_CONF_FINAL_DIR/squid.conf" ]];
    then
        cp /etc/squid/squid.conf.original $SQUID_CONF_FINAL_DIR/squid.conf;
    fi

    if [ -e "/etc/squid/squid.conf" ];
    then
        rm /etc/squid/squid.conf;
    fi
    
    ln -s $SQUID_CONF_FINAL_DIR/squid.conf /etc/squid/squid.conf;

    printf "Starting squid...\n";
    exec $(which squid) -f $SQUID_CONF_FINAL_DIR/squid.conf -NYCd 1 ${EXTRA_ARGS};

else

    exec "$@";

fi
