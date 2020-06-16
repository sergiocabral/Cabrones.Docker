INITIAL_DIR=$(pwd);

cd docker-compose;

VIRTUALIZATION=$(systemd-detect-virt -v) \
	PGID=$(grep docker /etc/group | cut -d ':' -f 3) \
	docker-compose up $@

cd $INITIAL_DIR;
