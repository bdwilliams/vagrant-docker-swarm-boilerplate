#!/bin/bash

# point it to vagrant1
cat << EOF > /etc/default/docker
DOCKER="/usr/bin/docker"
DOCKER_OPTS=" -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --cluster-store=consul://172.17.8.101:8500 --cluster-advertise=eth1:2376"
EOF

service docker restart

# run docker-compose
docker-compose -f /vagrant/docker-compose-vagrant3.yml up -d --timeout 20