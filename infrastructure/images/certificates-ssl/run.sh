#!/bin/bash

[ -z "$SUFFIX" ] && SUFFIX="##########   ";

printf "\n\n";
printf "$SUFFIX    ____          _   _  __ _           _              ____ ____  _     \n";
printf "$SUFFIX   / ___|___ _ __| |_(_)/ _(_) ___ __ _| |_ ___  ___  / ___/ ___|| |    \n";
printf "$SUFFIX  | |   / _ \ '__| __| | |_| |/ __/ _  | __/ _ \/ __| \___ \___ \| |    \n";
printf "$SUFFIX  | |__|  __/ |  | |_| |  _| | (_| (_| | ||  __/\__ \  ___) |__) | |___ \n";
printf "$SUFFIX   \____\___|_|   \__|_|_| |_|\___\__,_|\__\___||___/ |____/____/|_____|\n";
printf "\n";
printf "$SUFFIX Running...\n";
printf "\n\n";

# Verificando preenchimento dos argumentos.
    if [ -z "$CERTIFICATE_EMAIL" ]; 
    then 
        printf "$SUFFIX Email is empty.\n";
        printf "$SUFFIX Set value for environment variable: CERTIFICATE_EMAIL\n";
        exit 1;
    fi

    if [ -z "$CERTIFICATE_DOMAINS" ]; 
    then 
        printf "$SUFFIX List of domains is empty.\n";
        printf "$SUFFIX Set value for environment variable: CERTIFICATE_DOMAINS\n";
        printf "$SUFFIX Use format: domain1a.com,domain1b.com,domain1c.com+domain2.com+domain3a.com,domain3b.com\n";
        exit 1;
    fi

# Obtendo dados do certificado
    printf "$SUFFIX Requesting certificates to Let's Encrypt.\n";

    CERTBOT_WEBROOT="/usr/share/nginx/html";

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
            
            printf "$SUFFIX $CERTBOT_COMMAND\n";

            $CERTBOT_COMMAND
        fi

    done

    printf "\n";

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;
