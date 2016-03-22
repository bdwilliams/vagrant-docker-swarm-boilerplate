#!/bin/bash

apt-get update
apt-get install -y apt-transport-https ca-certificates curl unzip

# install docker
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y docker-engine

if [ ! -f /usr/local/bin/docker-compose ]; then
	curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose
	mv /tmp/docker-compose /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
fi

cat << EOF > /etc/default/docker
DOCKER="/usr/bin/docker"
DOCKER_OPTS=" -g /var/lib/docker --host=tcp://0.0.0.0:2376 --host=unix:///var/run/docker.sock"
EOF

usermod -aG docker vagrant 
service docker start

# run docker-compose
docker-compose -f /vagrant/docker-compose-base.yml up -d --timeout 20
