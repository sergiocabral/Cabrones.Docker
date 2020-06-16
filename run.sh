INITIAL_DIR=$(pwd);
cd docker-compose;
VIRTUALIZATION=$(systemd-detect-virt -v) docker-compose up $@
cd $INITIAL_DIR;