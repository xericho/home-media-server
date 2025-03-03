#!/bin/zsh

if [ -z "$1" ] 
then
  sudo docker compose pull
  sudo docker compose up --force-recreate --build -d
  sudo docker image prune -f
else
  sudo docker compose -f docker-compose.$1.yml pull
  sudo docker compose -f docker-compose.$1.yml up --force-recreate --build -d
  sudo docker image prune -f
fi
