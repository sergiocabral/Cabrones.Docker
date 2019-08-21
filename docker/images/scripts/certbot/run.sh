[ -z "$SUFFIX" ] && SUFFIX="##########   ";

printf "\n\n";
printf "$SUFFIX  _  _ _____ _____ ___  ___     __  ___ ___ _    \n";
printf "$SUFFIX | || |_   _|_   _| _ \/ __|   / / / __/ __| |   \n";
printf "$SUFFIX | __ | | |   | | |  _/\__ \  / /  \__ \__ \ |__ \n";
printf "$SUFFIX |_||_| |_|   |_| |_|  |___/ /_/   |___/___/____|\n";
printf "\n\n";                                                 

# Preparando repositório do apt-get.
    printf "$SUFFIX Preparing repository apt-get.\n";
    printf "\n";
    
    apt-get install -y software-properties-common;
    add-apt-repository universe;
    add-apt-repository ppa:certbot/certbot;

    apt-get update -y;
    apt-get upgrade -y;
    apt-get autoremove -y;

    printf "\n";

# Instalando certbot.
    printf "$SUFFIX Installing certbot...\n";
    printf "\n";

    apt-get install -y certbot python-certbot-apache;

    printf "\n";

# Obtendo dados do certificado
    printf "$SUFFIX Preparing command to install SSL.\n";

    if [ -z "$HTTP_DOMAIN" ]
    then
        HTTP_DOMAIN="localhost"
        printf "$SUFFIX Environment variable HTTP_DOMAIN not found. Using default value: %s\n" "$HTTP_DOMAIN";
    fi

    if [ -z "$HTTP_EMAIL" ]
    then
        HTTP_EMAIL="webmaster@localhost"
        printf "$SUFFIX Environment variable HTTP_EMAIL not found. Using default value: %s\n" "$HTTP_EMAIL";
    fi
    
    CERTBOT="certbot --apache --non-interactive --agree-tos --domain $HTTP_DOMAIN -m $HTTP_EMAIL"
    
    printf "" > /root/install-ssl.sh;
    
    printf "%s;\n" "$CERTBOT" >> /root/install-ssl.sh;
    printf "exit 0;\n" >> /root/install-ssl.sh;

    printf "$SUFFIX Command saved in /root/install-ssl.sh\n";

    chmod u+x /root/install-ssl.sh;

    printf "\n";

# Registrando no supervisor

    if [ "$HTTP_DOMAIN"=="localhost" ]
    then

        printf "$SUFFIX But it cannot be executed because it is localhost\n";
        printf "\n";

    else

        printf "$SUFFIX Registering on supervisor.\n";
        printf "\n";

        if [ ! -f "/etc/supervisor.conf" ]
        then
            touch /etc/supervisor.conf
        fi

        printf "[program:certbot]\n" >> /etc/supervisor.conf;
        printf "redirect_stderr=true\n" >> /etc/supervisor.conf;
        printf "stdout_logfile=/root/supervisor/output.certbot.log\n" >> /etc/supervisor.conf;
        printf "autostart=true\n" >> /etc/supervisor.conf;
        printf "autorestart=false\n" >> /etc/supervisor.conf;
        printf "command=bash -c \"sleep 60 && /root/install-ssl.sh\"\n" >> /etc/supervisor.conf;
        printf "\n" >> /etc/supervisor.conf;

    fi

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;