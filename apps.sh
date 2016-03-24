#!/bin/bash

sudo wget -O /usr/local/bin/scope https://git.io/scope
sudo chmod a+x /usr/local/bin/scope
sudo scope launch

export DOCKER_HOST=tcp://172.17.8.101:2375 # docker swarm
export KV_IP=172.17.8.101

# start an nginx service
docker-compose -f /vagrant/docker-compose-apps.yml up -d --timeout 20

# now scale it
# docker-compose -f /vagrant/docker-compose-apps.yml scale web=3