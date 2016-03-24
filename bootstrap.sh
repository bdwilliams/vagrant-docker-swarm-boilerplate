#!/bin/bash

apt-get update
apt-get install -y apt-transport-https ca-certificates curl

# install weave
sudo curl -L git.io/weave -o /usr/local/bin/weave
sudo chmod +x /usr/local/bin/weave
weave launch --init-peer-count 3

# install docker
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y docker-engine

usermod -aG docker vagrant 

cat << EOF > /etc/default/docker
DOCKER="/usr/bin/docker"
DOCKER_OPTS="--storage-driver=devicemapper -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --cluster-store=consul://127.0.0.1:8500 --cluster-advertise=eth1:2376"
EOF

service docker restart

# install docker-compose
if [ ! -f /usr/local/bin/docker-compose ]; then
	echo "Fetching docker-compose"
	curl --silent -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose
	mv /tmp/docker-compose /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
fi