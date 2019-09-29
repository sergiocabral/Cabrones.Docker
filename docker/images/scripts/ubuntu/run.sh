[ -z "$SUFFIX" ] && SUFFIX="##########   ";

printf "\n\n";
printf "$SUFFIX  _    _                _   _ _             _        \n";
printf "$SUFFIX | |  (_)_ _ _  ___ __ | | | | |__ _  _ _ _| |_ _  _ \n";
printf "$SUFFIX | |__| | ' \ || \ \ / | |_| | '_ \ || | ' \  _| || |\n";
printf "$SUFFIX |____|_|_||_\_,_/_\_\  \___/|_.__/\_,_|_||_\__|\_,_|\n";
printf "\n\n";

# Definição do timezone.

    printf "$SUFFIX Setting timezone definition.\n";
    printf "\n";

    if [ -z "$TZ" ]
    then
        printf "$SUFFIX Environment variable TZ not found. Using default value.\n";
        TZ="America/Sao_Paulo"
    fi

    printf "$SUFFIX Value defined is: $TZ\n";
    printf "\n";

    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;
    echo $TZ > /etc/timezone;

# Atualização do apt-get.
    printf "$SUFFIX Updating, upgrading and autoremoving apt-get.\n";
    printf "\n";

    apt-get update -y;
    apt-get upgrade -y;
    apt-get autoremove -y;

    printf "\n";

# Instalando pacotes úteis.
    printf "$SUFFIX Installing others utils packages...\n";
    printf "\n";

    printf "$SUFFIX Installing: sudo\n";
    printf "\n";
    apt-get install -y sudo;
    printf "\n";

    printf "$SUFFIX Installing: vim\n";
    printf "\n";
    apt-get install -y vim;
    printf "\n";

    printf "$SUFFIX Installing: iputils-ping\n";
    printf "\n";
    apt-get install -y iputils-ping;
    printf "\n";

    printf "$SUFFIX Installing: git\n";
    printf "\n";
    apt-get install -y git;
    printf "\n";

    printf "$SUFFIX Installing: supervisor\n";
    printf "\n";
    apt-get install -y supervisor;
    printf "\n";

# Preparando configuração inicial do supervisor
    printf "$SUFFIX Preparing supervisor.\n";
    printf "\n";

    if [ ! -f "/etc/supervisor.conf" ]
    then
        touch /etc/supervisor.conf;
    fi

    if [ ! -f "/root/supervisor/supervisord.log" ]
    then
        mkdir /root/supervisor;
        touch /root/supervisor/supervisord.log;
    fi

    printf "[supervisord]\n" >> /etc/supervisor.conf;
    printf "nodaemon=true\n" >> /etc/supervisor.conf;
    printf "directory=/root/supervisor\n" >> /etc/supervisor.conf;
    printf "childlogdir=/root/supervisor\n" >> /etc/supervisor.conf;
    printf "pidfile=/root/supervisor/supervisord.pid\n" >> /etc/supervisor.conf;    
    printf "logfile=/root/supervisor/supervisord.log\n" >> /etc/supervisor.conf;    
    printf "loglevel=debug\n" >> /etc/supervisor.conf;    
    printf "\n" >> /etc/supervisor.conf;

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;