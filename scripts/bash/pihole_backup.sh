#!/bin/bash

DOCKER_EXEC="docker exec -i pihole bash -c"

echo "Deleting backups older than 7 days"
$DOCKER_EXEC "find /backup -name "pi-hole-*" -mtime +7 -exec rm {} \;"

echo "Creating new backup"
$DOCKER_EXEC "cd /backup && pihole -a -t"


