[ -z "$SUFFIX" ] && SUFFIX="## [ CABRONES ] ##   ";

printf "\n\n";
printf "$SUFFIX   ___                   ___ ___ _  _  \n";
printf "$SUFFIX  / _ \ _ __  ___ _ _   / __/ __| || | \n";
printf "$SUFFIX | (_) | '_ \/ -_) ' \  \__ \__ \ __ | \n";
printf "$SUFFIX  \___/| .__/\___|_||_| |___/___/_||_| \n";
printf "$SUFFIX       |_|                             \n";
printf "\n\n";

# Instalação do Open SSH Server.
    printf "$SUFFIX Installing Open SSH Server.\n";
    printf "\n";

    apt-get install -y openssh-server;

    if [ ! -f "/run/sshd" ]
    then
        mkdir /run/sshd
    fi

    printf "\n";

# Backup de arquivos originais.
    printf "$SUFFIX Saving backup of original files:\n";

    printf "$SUFFIX  > /etc/ssh/ssh_config --> /etc/ssh/ssh_config.original\n";
    cp /etc/ssh/ssh_config /etc/ssh/ssh_config.original
    printf "$SUFFIX  > /etc/ssh/sshd_config --> /etc/ssh/sshd_config.original\n";
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original

    printf "\n";

# Definindo configurações.
    if [ -f "./ssh_config" ]
    then

        printf "$SUFFIX Writing configuration's file:\n";

        printf "$SUFFIX  > /etc/ssh/ssh_config\n";
        cp ssh_config /etc/ssh/ssh_config

        printf "\n";

    else

        printf "$SUFFIX File not found: ssh_config\n";
        printf "$SUFFIX Configuration setting ignored. Using default.\n";
        printf "\n";

    fi
    
    if [ -f "./sshd_config" ]
    then

        printf "$SUFFIX Writing configuration's file:\n";

        printf "$SUFFIX  > /etc/ssh/sshd_config\n";
        cp sshd_config /etc/ssh/sshd_config

        printf "\n";

    else

        printf "$SUFFIX File not found: sshd_config\n";
        printf "$SUFFIX Configuration setting ignored. Using default.\n";
        printf "\n";

    fi

# Configurando autenticação.
    printf "$SUFFIX Creating user for authentication in ssh.\n";

    if [ -z "$SSH_USER" ]
    then
        SSH_USER="sshuser"
        printf "$SUFFIX Environment variable SSH_USER not found. Using default value: %s\n" "$SSH_USER";
    fi

    if [ -z "$SSH_PASSWORD" ]
    then
        SSH_PASSWORD="password"
        printf "$SUFFIX Environment variable SSH_PASSWORD not found. Using default value: %s\n" "$SSH_PASSWORD";
    fi

    printf "\n";

    adduser --disabled-password --gecos "" $SSH_USER
    echo $SSH_USER:$SSH_PASSWORD | chpasswd
    usermod -aG sudo $SSH_USER

    printf "\n";

# Configura mensagem de boas-vindas motd
    printf "$SUFFIX Configuring welcome message, motd.\n";

    cp motd /etc/motd
    chmod -x /etc/update-motd.d/*
    chmod +x /etc/update-motd.d/00-*

    printf "\n";

# Registrando no supervisor
    printf "$SUFFIX Registering on supervisor.\n";
    printf "\n";

    if [ ! -f "/etc/supervisor.conf" ]
    then
        touch /etc/supervisor.conf
    fi
    
    printf "[program:openssh]\n" >> /etc/supervisor.conf;
    printf "command=/usr/sbin/sshd -D\n" >> /etc/supervisor.conf;
    printf "\n" >> /etc/supervisor.conf;

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;