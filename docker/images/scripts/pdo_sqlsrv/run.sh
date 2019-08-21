[ -z "$SUFFIX" ] && SUFFIX="##########   ";

printf "\n\n";
printf "$SUFFIX  ___ ___   ___          ___       _ ___             \n";
printf "$SUFFIX | _ \   \ / _ \        / __| __ _| / __|_ ___ __    \n";
printf "$SUFFIX |  _/ |) | (_) |       \__ \/ _\` | \__ \ '_\ V /    \n";
printf "$SUFFIX |_| |___/ \___/   ___  |___/\__, |_|___/_|  \_/     \n";
printf "$SUFFIX                  |___|         |_|                  \n";
printf "\n\n";

# Preparando repositório do apt-get.
    printf "$SUFFIX Preparing repositories apt-get, pear and pecl.\n";
    printf "\n";
    
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -;
    curl https://packages.microsoft.com/config/ubuntu/18.10/prod.list > /etc/apt/sources.list.d/mssql-release.list;

    apt-get update -y;
    apt-get upgrade -y;
    apt-get autoremove -y;

    pear update-channels;
    pecl update-channels;
    pear upgrade;
    pecl upgrade;

    printf "\n";

# Instalando drivers.
    printf "$SUFFIX Installing drivers...\n";
    printf "\n";

    printf "$SUFFIX Installing: msodbcsql17\n";
    printf "\n";
    ACCEPT_EULA=Y apt-get install -y msodbcsql17;
    printf "\n";

    printf "$SUFFIX Installing: unixodbc-dev\n";
    printf "\n";
    apt-get install -y unixodbc-dev;
    printf "\n";

    printf "$SUFFIX Installing: sqlsrv\n";
    printf "\n";
    pecl install sqlsrv;
    printf "\n";

    printf "$SUFFIX Installing: pdo_sqlsrv\n";
    printf "\n";
    pecl install pdo_sqlsrv;
    printf "\n";

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;