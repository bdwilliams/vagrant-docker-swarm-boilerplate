# Vagrant + Docker + Swarm + Compose + Consul + Registrator + REX-Ray

Host machine is running a packer built version of Ubuntu 14.04 where the virtualbox SATA controller defaults to 30 portcount

## Requires

VirtualBox 5.0.10+

## Getting Started

1.) Start the Virtualbox Media Library (in a different terminal window)

<pre>
/Applications/VirtualBox.app/Contents/MacOS/vboxwebsrv -H 0.0.0.0 -v
</pre>

2.) Clone this project and vagrant up

<pre>
git clone git@github.com:bdwilliams/vagrant-docker-swarm-boilerplate.git
cd vagrant-docker-swarm-boilerplate
vagrant up
</pre>

3.) Make sure that the following hosts exist in your /etc/hosts file

<pre>
172.17.8.101	vagrant1 vagrant1.vm
172.17.8.102	vagrant2 vagrant2.vm
172.17.8.103	vagrant3 vagrant3.vm
</pre>

4.) After vagrant is finished, you you verify that everything was successful

<pre>
vagrant ssh vagrant1 -c 'docker -H tcp://172.17.8.101:2375 info'
</pre>

Output should appear similar to:

<pre>
Containers: 6
 Running: 6
 Paused: 0
 Stopped: 0
Images: 5
Server Version: swarm/1.1.3
Role: replica
Primary:
Strategy: spread
Filters: health, port, dependency, affinity, constraint
Nodes: 3
 vagrant1: 172.17.8.101:2376
  └ Status: Healthy
  └ Containers: 4
  └ Reserved CPUs: 0 / 1
  └ Reserved Memory: 0 B / 1.535 GiB
  └ Labels: executiondriver=native-0.2, kernelversion=3.19.0-25-generic, operatingsystem=Ubuntu 14.04.3 LTS, storagedriver=aufs
  └ Error: (none)
  └ UpdatedAt: 2016-03-23T16:41:04Z
 vagrant2: 172.17.8.102:2376
  └ Status: Healthy
  └ Containers: 1
  └ Reserved CPUs: 0 / 1
  └ Reserved Memory: 0 B / 1.535 GiB
  └ Labels: executiondriver=native-0.2, kernelversion=3.19.0-25-generic, operatingsystem=Ubuntu 14.04.3 LTS, storagedriver=aufs
  └ Error: (none)
  └ UpdatedAt: 2016-03-23T16:41:15Z
 vagrant3: 172.17.8.103:2376
  └ Status: Healthy
  └ Containers: 1
  └ Reserved CPUs: 0 / 1
  └ Reserved Memory: 0 B / 1.535 GiB
  └ Labels: executiondriver=native-0.2, kernelversion=3.19.0-25-generic, operatingsystem=Ubuntu 14.04.3 LTS, storagedriver=aufs
  └ Error: (none)
  └ UpdatedAt: 2016-03-23T16:41:09Z
Plugins:
 Volume:
 Network:
Kernel Version: 3.19.0-25-generic
Operating System: linux
Architecture: amd64
CPUs: 3
Total Memory: 4.606 GiB
Name: 32bca38d2ec5
Connection to 127.0.0.1 closed.
</pre>

5.) Check the Consul UI at http://172.17.8.101:8500/ui

6.) Nginx Welcome page at http://172.17.8.101

## TODO
Consul Templates
SSL/TLS certificates for Docker
