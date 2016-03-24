#!/bin/bash
set -x

# run weave
weave launch --init-peer-count 3

# install weave scope
sudo wget -O /usr/local/bin/scope https://git.io/scope
sudo chmod a+x /usr/local/bin/scope
sudo scope launch

# run docker-compose for consul
docker-compose -f /vagrant/vagrant1/docker-compose-consul.yml up -d --timeout 20

# wait for the consul container (port 8500)
COUNTER=0
until nc -z 127.0.0.1 8500
do
    echo "${COUNTER} waiting for the consul container..."
    COUNTER=$[$COUNTER +1]
    sleep 5

    if [[ $COUNTER -gt 30 ]]; then
    	echo "Timeout limit reached.  Exiting..."
    	exit 1
    fi
done

# wait for docker to use the config store (consul)
COUNTER=0
until docker network create -d overlay temp > /dev/null 2>&1
do
	echo "${COUNTER} waiting for docker config store to be ready..."
    COUNTER=$[$COUNTER +1]
    sleep 5

    if [[ $COUNTER -gt 30 ]]; then
    	echo "Timeout limit reached.  Exiting..."
    	exit 1
    fi
done

# remove temp network
docker network rm temp