[ -z "$SUFFIX" ] && SUFFIX="##########   ";

printf "\n\n";
printf "$SUFFIX  ___ _  _ ___  \n";
printf "$SUFFIX | _ \ || | _ \ \n";
printf "$SUFFIX |  _/ __ |  _/ \n";
printf "$SUFFIX |_| |_||_|_|   \n";
printf "\n\n";
               
# Preparando repositório do apt-get.
    printf "$SUFFIX Preparing repository of apt-get.\n";
    printf "\n";
    
    apt-get install -y software-properties-common;
    LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php;
    add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.1/ubuntu trusty main';

    apt-get update -y;
    apt-get upgrade -y;
    apt-get autoremove -y;

    printf "\n";

# Instalando PHP e módulos.
    printf "$SUFFIX Installing PHP and modules...\n";
    printf "\n";

    printf "$SUFFIX Installing: php\n";
    printf "\n";
    apt-get install -y php;
    printf "\n";

    printf "$SUFFIX Installing: php-xdebug\n";
    printf "\n";
    apt-get install -y php-xdebug;
    printf "\n";

    printf "$SUFFIX Installing: php-mbstring\n";
    printf "\n";
    apt-get install -y php-mbstring;
    printf "\n";

    printf "$SUFFIX Installing: php-zip\n";
    printf "\n";
    apt-get install -y php-zip;
    printf "\n";

    printf "$SUFFIX Installing: php-mysql\n";
    printf "\n";
    apt-get install -y php-mysql;
    printf "\n";

    printf "$SUFFIX Installing: php-xml\n";
    printf "\n";
    apt-get install -y php-xml;
    printf "\n";

    printf "$SUFFIX Installing: php-pear\n";
    printf "\n";
    apt-get install -y php-pear;
    printf "\n";

    printf "$SUFFIX Installing: php-dev\n";
    printf "\n";
    apt-get install -y php-dev;
    printf "\n";

# Backup de arquivos originais.
    printf "$SUFFIX Saving backup of original files:\n";

    for file in /etc/php/*
    do
        
        if [ -f "$file/apache2/php.ini" ]
        then

            printf "$SUFFIX  > $file/apache2/php.ini --> $file/apache2/php.ini.original\n";

            cp $file/apache2/php.ini $file/apache2/php.ini.original;
            cp ./php.ini $file/apache2/php.ini;

        fi

    done

    printf "\n";

# Definindo configurações.
    if [ -f "./php.ini" ]
    then

        printf "$SUFFIX Writing configuration's file:\n";

        for file in /etc/php/*
        do
            
            if [ -f "$file/apache2/php.ini" ]
            then

                printf "$SUFFIX  > $file/apache2/php.ini\n";

                cp ./php.ini $file/apache2/php.ini;

            fi

        done

        printf "\n";

    else

        printf "$SUFFIX File not found: php.ini\n";
        printf "$SUFFIX Configuration setting ignored. Using default.\n";
        printf "\n";

    fi

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;