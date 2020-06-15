#!/bin/bash

[ -z "$SUFFIX" ] && SUFFIX="##########   ";

printf "\n\n";
printf "$SUFFIX    ____          _   _  __ _           _              ____ ____  _     \n";
printf "$SUFFIX   / ___|___ _ __| |_(_)/ _(_) ___ __ _| |_ ___  ___  / ___/ ___|| |    \n";
printf "$SUFFIX  | |   / _ \ '__| __| | |_| |/ __/ _  | __/ _ \/ __| \___ \___ \| |    \n";
printf "$SUFFIX  | |__|  __/ |  | |_| |  _| | (_| (_| | ||  __/\__ \  ___) |__) | |___ \n";
printf "$SUFFIX   \____\___|_|   \__|_|_| |_|\___\__,_|\__\___||___/ |____/____/|_____|\n";
printf "\n";
printf "$SUFFIX Configuring...\n";
printf "\n\n";

# Preparando repositório do apt-get.
    printf "$SUFFIX Preparing repository apt-get.\n";
    printf "\n";
    
    apt-get update -y;

    printf "\n";

# Instalando certbot.
    printf "$SUFFIX Installing certbot...\n";
    printf "\n";

    apt-get install -y certbot;

    printf "\n";

# Finalizado.
    printf "$SUFFIX Finished.\n";
    printf "\n";

    exit 0;
