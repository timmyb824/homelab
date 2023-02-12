#!/bin/bash

COMPOSE="/usr/local/bin/docker-compose --ansi never"
DOCKER="/usr/bin/docker"

cd $HOME/wordpress/
$COMPOSE run certbot renew && $COMPOSE kill -s SIGHUP webserver
$DOCKER system prune -af
