CERT_EMAIL_DEFAULT=certbot@cabral.srv.br

if [ -z "$CERT_EMAIL" ]; 
then 
    CERT_EMAIL=$CERT_EMAIL_DEFAULT;
fi

CERT_DOMAINS_GROUPS=$1

if [ -z "$CERT_DOMAINS_GROUPS" ]; 
then 
    printf "Pass the list of domains as an argument as:\n";
    printf "  domain1a.com+domain1b.com+domain1c.com,domain2.com,domain3a.com+domain3b.com\n";
    printf "\n";
    exit 1;
fi

DOCKER_CONTAINER=nginx-certbot

printf "### Creating docker container $DOCKER_CONTAINER with NGINX...\n";

DOCKER_VOLUME=$(pwd);

docker run \
    -it \
    -d \
    --name $DOCKER_CONTAINER \
    -p 80:80 \
    -p 443:443 \
    -v $DOCKER_VOLUME:/etc/letsencrypt/archive \
    nginx

printf "### Installing CERTBOT...\n";

docker exec -i $DOCKER_CONTAINER bash -c "apt-get update -y"

docker exec -i $DOCKER_CONTAINER bash -c "apt-get install -y certbot"

printf "### Requesting certificates to Let's Encrypt...\n";

CERTBOT_WEBROOT="/usr/share/nginx/html";

IFS=',' read -ra CERT_DOMAINS_GROUPS_LIST <<< "$CERT_DOMAINS_GROUPS"
for CERT_DOMAINS_GROUP in "${CERT_DOMAINS_GROUPS_LIST[@]}"; do

    CERTBOT_ARG_DOMAIN="";
    CERTBOT_ARG_NAME="";

    IFS='+' read -ra CERT_DOMAINS_LIST <<< "$CERT_DOMAINS_GROUP"
    for CERT_DOMAIN in "${CERT_DOMAINS_LIST[@]}"; do

        if [ -z "$CERTBOT_ARG_NAME" ];
        then
            CERTBOT_ARG_NAME="--cert-name $CERT_DOMAIN";
        fi

        CERTBOT_ARG_DOMAIN="$CERTBOT_ARG_DOMAIN-d $CERT_DOMAIN ";
    done

    if [ -n "$CERTBOT_ARG_DOMAIN" ];
    then
        CERTBOT_COMMAND="certbot certonly -n --agree-tos --webroot -w $CERTBOT_WEBROOT -m $CERT_EMAIL $CERTBOT_ARG_NAME $CERTBOT_ARG_DOMAIN";
        
        printf "### $CERTBOT_COMMAND\n";

        docker exec -i $DOCKER_CONTAINER bash -c "$CERTBOT_COMMAND"
    fi

done

printf "### Discarding container $DOCKER_CONTAINER...\n";

docker rm $(docker stop $DOCKER_CONTAINER)

printf "### Finished.\n";
printf "\n";

exit 0;
