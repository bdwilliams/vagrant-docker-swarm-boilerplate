#!/bin/bash
set -x

# point it to vagrant1
cat << EOF > /etc/default/docker
DOCKER="/usr/bin/docker"
DOCKER_OPTS="--storage-driver=devicemapper -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --cluster-store=consul://172.17.8.101:8500 --cluster-advertise=eth1:2376"
EOF

service docker restart

# weave
weave launch --init-peer-count 3 172.17.8.101 172.17.8.102
weave status

# install weave scope
sudo wget -O /usr/local/bin/scope https://git.io/scope
sudo chmod a+x /usr/local/bin/scope
sudo scope launch

# run docker-compose
export DOCKER_HOST=tcp://172.17.8.103:2376 # docker
docker-compose -f /vagrant/vagrant3/docker-compose-vagrant3.yml up -d --timeout 20

# now, lets add some examples
/vagrant/apps.sh
