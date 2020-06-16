#!/bin/bash

if [ -z "$CERTIFICATE_EMAIL" ]; 
then 
    printf "Email is empty.\n";
    printf "Set value for environment variable: CERTIFICATE_EMAIL\n";
    exit 1;
fi

if [ -z "$CERTIFICATE_DOMAINS" ]; 
then 
    printf "List of domains is empty.\n";
    printf "Set value for environment variable: CERTIFICATE_DOMAINS\n";
    printf "Use format: domain1a.com,domain1b.com,domain1c.com+domain2.com+domain3a.com,domain3b.com\n";
    exit 1;
fi

printf "Starting temporary webserver.\n";

NGINX_CONF_DIR="/etc/nginx/conf.d";
mkdir $NGINX_CONF_DIR/backups;
mv $NGINX_CONF_DIR/*.conf $NGINX_CONF_DIR/backups;

CERTBOT_WEBROOT="/tmp/certbot";
mkdir $CERTBOT_WEBROOT;

NGINX_CONF_FILE="$NGINX_CONF_DIR/default.conf";
printf "server {" > $NGINX_CONF_FILE;
printf "listen 80;" >> $NGINX_CONF_FILE;
printf "root $CERTBOT_WEBROOT;" >> $NGINX_CONF_FILE;
printf "}" >> $NGINX_CONF_FILE;

nginx;

printf "Requesting certificates to Let's Encrypt.\n";

IFS='+' read -ra CERTIFICATE_DOMAINS_LIST <<< "$CERTIFICATE_DOMAINS"
for CERTIFICATE_DOMAINS_GROUP in "${CERTIFICATE_DOMAINS_LIST[@]}"; do

    CERTBOT_ARG_DOMAIN="";
    CERTBOT_ARG_NAME="";

    IFS=',' read -ra CERTIFICATE_DOMAINS_LIST <<< "$CERTIFICATE_DOMAINS_GROUP"
    for CERTIFICATE_DOMAIN in "${CERTIFICATE_DOMAINS_LIST[@]}"; do

        if [ -z "$CERTBOT_ARG_NAME" ];
        then
            CERTBOT_ARG_NAME="--cert-name $CERTIFICATE_DOMAIN";
        fi

        CERTBOT_ARG_DOMAIN="$CERTBOT_ARG_DOMAIN-d $CERTIFICATE_DOMAIN ";
    done

    if [ -n "$CERTBOT_ARG_DOMAIN" ];
    then
        CERTBOT_COMMAND="certbot certonly -n --agree-tos --webroot -w $CERTBOT_WEBROOT -m $CERTIFICATE_EMAIL $CERTBOT_ARG_NAME $CERTBOT_ARG_DOMAIN";
        
        printf "$CERTBOT_COMMAND\n";

        $CERTBOT_COMMAND
    fi

done

printf "Killing temporary webserver.\n";
nginx -s quit;

printf "Removing path of webroot: $CERTBOT_WEBROOT\n";
ls -la $CERTBOT_WEBROOT;
rm -R $CERTBOT_WEBROOT;

CERTBOT_PATH="/etc/letsencrypt";
CERTBOT_CERTIFICATES="$CERTBOT_PATH/archive";
printf "Path of certificates: $CERTBOT_CERTIFICATES\n";
ls -lR $CERTBOT_CERTIFICATES;
CERTBOT_CERTIFICATES="$CERTBOT_PATH/live";
printf "Path of certificates: $CERTBOT_CERTIFICATES\n";
ls -lR $CERTBOT_CERTIFICATES;

rm $NGINX_CONF_DIR/*.conf;
mv $NGINX_CONF_DIR/backups/*.conf $NGINX_CONF_DIR;
rm -R $NGINX_CONF_DIR/backups;

printf "SSL certificate request finished.\n";
