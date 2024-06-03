#!/bin/zsh

sudo docker-compose pull
sudo docker-compose up --force-recreate --build -d
sudo docker image prune -f
