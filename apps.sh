#!/bin/bash

# start an nginx service
export KV_IP=172.17.8.101
export DOCKER_HOST=tcp://172.17.8.101:2376 # docker swarm manager
docker-compose -f /vagrant/docker-compose-apps.yml up -d --timeout 20

# now scale it
docker-compose -f /vagrant/docker-compose-apps.yml scale web=5