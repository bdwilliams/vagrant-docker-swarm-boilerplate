#!/bin/bash

# run docker-compose for consul
docker-compose -f /vagrant/docker-compose-consul.yml up -d

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

# run docker-compose
docker-compose -f /vagrant/docker-compose-vagrant1.yml up -d --timeout 20