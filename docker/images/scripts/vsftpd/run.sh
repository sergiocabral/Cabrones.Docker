[ -z "$SUFFIX" ] && SUFFIX="## [ CABRONES ] ##   ";

printf "\n\n";
printf "$SUFFIX          __ _            _   ___ _____ ___   ___                       \n";
printf "$SUFFIX __ _____/ _| |_ _ __  __| | | __|_   _| _ \ / __| ___ _ ___ _____ _ _  \n";
printf "$SUFFIX \ V (_-<  _|  _| '_ \/ _\` | | _|  | | |  _/ \__ \/ -_) '_\ V / -_) '_| \n";
printf "$SUFFIX  \_//__/_|  \__| .__/\__,_| |_|   |_| |_|   |___/\___|_|  \_/\___|_|   \n";
printf "$SUFFIX                |_|                                                     \n";
printf "\n\n";

# Instalação do vsftpd FTP Server.
    printf "$SUFFIX Installing vsftpd FTP Server.\n";
    printf "\n";

    apt-get install -y vsftpd libpam-pwdfile;

    printf "\n";

# Backup de arquivos originais.
    printf "$SUFFIX Saving backup of original files:\n";

    printf "$SUFFIX  > /etc/vsftpd.conf --> /etc/vsftpd.conf.original\n";
    cp /etc/vsftpd.conf /etc/vsftpd.conf.original
    printf "$SUFFIX  > /etc/pam.d/vsftpd --> /etc/pam.d/vsftpd.original\n";
    cp /etc/pam.d/vsftpd /etc/pam.d/vsftpd.original

    printf "\n";

# Definindo configurações.
    if [ -f "./vsftpd.conf" ]
    then

        printf "$SUFFIX Writing configuration's file:\n";

        printf "$SUFFIX  > /etc/vsftpd.conf\n";
        cp vsftpd.conf /etc/vsftpd.conf

        printf "\n";

    else

        printf "$SUFFIX File not found: vsftpd.conf\n";
        printf "$SUFFIX Configuration setting ignored. Using default.\n";
        printf "\n";

    fi

    if [ -f "./vsftpd" ]
    then

        printf "$SUFFIX Writing configuration's file:\n";

        printf "$SUFFIX  > /etc/pam.d/vsftpd\n";
        cp vsftpd /etc/pam.d/vsftpd

        printf "\n";

    else

        printf "$SUFFIX File not found: vsftpd\n";
        printf "$SUFFIX Configuration setting ignored. Using default.\n";
        printf "\n";

    fi

# Configurando autenticação.
    printf "$SUFFIX Setting authentication data.\n";

    if [ -z "$FTP_USER" ]
    then
        FTP_USER="deploy"
        printf "$SUFFIX Environment variable FTP_USER not found. Using default value: %s\n" "$FTP_USER";
    fi

    if [ -z "$FTP_PASSWORD" ]
    then
        FTP_PASSWORD="password"
        printf "$SUFFIX Environment variable FTP_PASSWORD not found. Using default value: %s\n" "$FTP_PASSWORD";
    fi

    printf "\n";

    htpasswd -cdb /etc/vsftpd.passwd $FTP_USER $FTP_PASSWORD;

    chown -R ftp.ftp /var/www/*

    printf "\n";

# Registrando no supervisor
    printf "$SUFFIX Registering on supervisor.\n";
    printf "\n";

    if [ ! -f "/etc/supervisor.conf" ]
    then
        touch /etc/supervisor.conf
    fi
    
    printf "[program:vsftpd]\n" >> /etc/supervisor.conf;
    printf "command=vsftpd\n" >> /etc/supervisor.conf;
    printf "\n" >> /etc/supervisor.conf;

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;