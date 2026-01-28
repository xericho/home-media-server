#!/bin/zsh
# This script runs a watchtower scan only, NO UPDATES

# Sources the .env 
set -a
source .env
set +a


sudo docker run --rm \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-e TZ=$TZ \
	-e WATCHTOWER_NOTIFICATION_URL=ntfy://$NTFY_USER:$NTFY_PASSWORD@$NTFY_URL \
	nickfedor/watchtower \
	--run-once --monitor-only
