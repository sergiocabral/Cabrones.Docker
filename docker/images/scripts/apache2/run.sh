[ -z "$SUFFIX" ] && SUFFIX="##########   ";

printf "\n\n";
printf "$SUFFIX    _                 _          _  _ _____ _____ ___   ___                      \n";
printf "$SUFFIX   /_\  _ __  __ _ __| |_  ___  | || |_   _|_   _| _ \ / __| ___ _ ___ _____ _ _ \n";
printf "$SUFFIX  / _ \| '_ \/ _\` / _| ' \/ -_) | __ | | |   | | |  _/ \__ \/ -_) '_\ V / -_) '_|\n";
printf "$SUFFIX /_/ \_\ .__/\__,_\__|_||_\___| |_||_| |_|   |_| |_|   |___/\___|_|  \_/\___|_|  \n";
printf "$SUFFIX       |_|                                                                       \n";
printf "\n\n";

# Instalação do Apache HTTP Server.
    printf "$SUFFIX Installing Apache HTTP Server.\n";
    printf "\n";

    apt-get install -y apache2;

    printf "\n";

# Backup de arquivos originais.
    printf "$SUFFIX Saving backup of original files:\n";

    printf "$SUFFIX  > /etc/apache2/apache2.conf --> /etc/apache2/apache2.conf.original\n";
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.original

    printf "\n";

# Ativando módulos do Apache HTTP Server
    printf "$SUFFIX Activating modules:\n";

    printf "$SUFFIX  > rewrite\n";
    a2enmod rewrite;

    printf "$SUFFIX  > ssl\n";
    a2enmod ssl;

    printf "\n";

# Definindo configurações.
    if [ -f "./apache2.conf" ]
    then

        printf "$SUFFIX Writing configuration's file:\n";

        printf "$SUFFIX  > /etc/apache2/apache2.conf\n";
        cp apache2.conf /etc/apache2/apache2.conf

        printf "\n";

    else

        printf "$SUFFIX File not found: apache2.conf\n";
        printf "$SUFFIX Configuration setting ignored. Using default.\n";
        printf "\n";

    fi

# Removendo todos os sites
    printf "$SUFFIX Removing all default website.\n";
    printf "\n";

    for file in /etc/apache2/sites-available/*
    do
        filename="$(basename -- $file)";
        a2dissite $filename;
        rm $file;
    done

    printf "\n";

# Criando o website padrão.
    printf "$SUFFIX Creating default website.\n";

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

    printf "\n";

    mv /var/www/html /var/www/_default;

    touch /etc/apache2/sites-available/_default.conf;

    printf "<VirtualHost *:80>\n" >> /etc/apache2/sites-available/_default.conf;
    printf "    ServerName %s\n" "$HTTP_DOMAIN" >> /etc/apache2/sites-available/_default.conf;
    printf "    ServerAdmin %s\n" "$HTTP_EMAIL" >> /etc/apache2/sites-available/_default.conf;
    printf "    DocumentRoot /var/www/_default\n" >> /etc/apache2/sites-available/_default.conf;
    printf "    ErrorLog \${APACHE_LOG_DIR}/error.log\n" >> /etc/apache2/sites-available/_default.conf;
    printf "    CustomLog \${APACHE_LOG_DIR}/access.log combined\n" >> /etc/apache2/sites-available/_default.conf;
    printf "</VirtualHost>\n" >> /etc/apache2/sites-available/_default.conf;

    a2ensite _default.conf;

    printf "\n";

# Registrando no supervisor
    printf "$SUFFIX Registering on supervisor.\n";
    printf "\n";

    if [ ! -f "/etc/supervisor.conf" ]
    then
        touch /etc/supervisor.conf
    fi
    
    printf "[program:apache2]\n" >> /etc/supervisor.conf;
    printf "redirect_stderr=true\n" >> /etc/supervisor.conf;
    printf "stdout_logfile=/root/supervisor/output.apache2.log\n" >> /etc/supervisor.conf;    
    printf "autostart=true\n" >> /etc/supervisor.conf;
    printf "autorestart=true\n" >> /etc/supervisor.conf;
    printf "command=apache2ctl -D FOREGROUND\n" >> /etc/supervisor.conf;
    printf "\n" >> /etc/supervisor.conf;

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;