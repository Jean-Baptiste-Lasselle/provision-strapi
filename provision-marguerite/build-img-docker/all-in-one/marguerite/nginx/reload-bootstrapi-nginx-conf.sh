#!/bin/bash

# - 
docker exec -it bootstrapi /bin/bash -c "rm -f /etc/nginx/conf.d/bootstrapi.conf"
docker cp ./bootstrapi.conf bootstrapi:/etc/nginx/conf.d/bootstrapi.conf

