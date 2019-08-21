[ -z "$SUFFIX" ] && SUFFIX="##########   ";

printf "\n\n";
printf "$SUFFIX  __  __          _      ___  ___  \n";
printf "$SUFFIX |  \/  |__ _ _ _(_)__ _|   \| _ ) \n";
printf "$SUFFIX | |\/| / _\` | '_| / _\` | |) | _ \\ \n";
printf "$SUFFIX |_|  |_\__,_|_| |_\__,_|___/|___/ \n";
printf "\n\n";

# Preparando repositório do apt-get.
    printf "$SUFFIX Preparing repository of apt-get.\n";
    printf "\n";
    
    apt-get install -y software-properties-common;
    apt-key adv --recv-keys -keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db;
    add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.1/ubuntu trusty main';

    apt-get update -y;
    apt-get upgrade -y;
    apt-get autoremove -y;

    printf "\n";

# Instalação do MariaDB.
    printf "$SUFFIX Installing MariaDB.\n";
    printf "\n";

    apt-get install -y mariadb-server;

    printf "\n";

# Backup de arquivos originais.
    printf "$SUFFIX Saving backup of original files:\n";

    printf "$SUFFIX  > /etc/mysql/my.cnf --> /etc/mysql/my.cnf.original\n";
    cp /etc/mysql/my.cnf /etc/mysql/my.cnf.original

    printf "\n";

# Configurando autenticação.
    if [ -f "./authentication.sql" ]
    then

        printf "$SUFFIX Setting authentication data.\n";

        if [ -z "$MYSQL_ROOT_USER" ]
        then
            MYSQL_ROOT_USER="root"
            printf "$SUFFIX Environment variable MYSQL_ROOT_USER not found. Using default value: %s\n" "$MYSQL_ROOT_USER";
        fi

        if [ -z "$MYSQL_ROOT_HOST" ]
        then
            MYSQL_ROOT_HOST="%"
            printf "$SUFFIX Environment variable MYSQL_ROOT_HOST not found. Using default value: %s\n" "$MYSQL_ROOT_HOST";
        fi

        if [ -z "$MYSQL_ROOT_PASSWORD" ]
        then
            MYSQL_ROOT_PASSWORD=password
            printf "$SUFFIX Environment variable MYSQL_ROOT_PASSWORD not found. Using default value: %s\n" "$MYSQL_ROOT_PASSWORD";
        fi

        printf "\n";

        sed 's/#MYSQL_ROOT_USER#/'"$MYSQL_ROOT_USER"'/g' ./authentication.sql | sed 's/#MYSQL_ROOT_HOST#/'"$MYSQL_ROOT_HOST"'/g' | sed 's/#MYSQL_ROOT_PASSWORD#/'"$MYSQL_ROOT_PASSWORD"'/g' > ./authentication_.sql;

        service mysql start
        mysql < ./authentication_.sql;
        rm ./authentication_.sql;

        printf "\n";

    else

        printf "$SUFFIX File not found: authentication.sql\n";
        printf "$SUFFIX Authentication setting ignored. Using default.\n";
        printf "\n";

    fi

# Definindo configurações.
    if [ -f "./my.cnf" ]
    then

        printf "$SUFFIX Writing configuration's file:\n";

        printf "$SUFFIX  > /etc/mysql/my.cnf\n";
        cp my.cnf /etc/mysql/my.cnf

        printf "\n";

    else

        printf "$SUFFIX File not found: my.cnf\n";
        printf "$SUFFIX Configuration setting ignored. Using default.\n";
        printf "\n";

    fi

# Registrando no supervisor
    printf "$SUFFIX Registering on supervisor.\n";
    printf "\n";

    if [ ! -f "/etc/supervisor.conf" ]
    then
        touch /etc/supervisor.conf
    fi
    
    printf "[program:mariadb]\n" >> /etc/supervisor.conf;
    printf "redirect_stderr=true\n" >> /etc/supervisor.conf;
    printf "stdout_logfile=/root/supervisor/output.mariadb.log\n" >> /etc/supervisor.conf;    
    printf "autostart=true\n" >> /etc/supervisor.conf;
    printf "autorestart=true\n" >> /etc/supervisor.conf;
    printf "command=mysqld_safe\n" >> /etc/supervisor.conf;
    printf "\n" >> /etc/supervisor.conf;

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;