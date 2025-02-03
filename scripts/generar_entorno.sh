#!/bin/bash

###################################
# Borrar  las maquinas 
###################################

docker rm -f  debian1
docker rm -f  debian2
docker rm -f  rocky1
docker rm -f  rocky2
docker rm -f  ubuntu1
docker rm -f  mysql1
docker rm -f  mysql2
docker rm -f  tomcat1
docker rm -f  tomcat2

###################################
# Borrar  la red
###################################

docker network rm ansible

###################################
# Borrar y recrear la red y las maquinas
###################################
docker network create ansible --subnet=172.18.0.0/16
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --ip 172.18.0.2 --cgroupns=host --name=debian1 --network=ansible apasoft/debian11-ansible 
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --ip 172.18.0.3 --cgroupns=host --name=debian2 --network=ansible apasoft/debian11-ansible 
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --ip 172.18.0.5 --cgroupns=host --name=rocky1 --network=ansible apasoft/rocky9-ansible 
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --ip 172.18.0.6 --cgroupns=host --name=rocky2 --network=ansible apasoft/rocky9-ansible 
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --ip 172.18.0.8 --cgroupns=host --name=ubuntu1 --network=ansible apasoft/ubuntu22-ansible 
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --ip 172.18.0.10 --cgroupns=host --name=mysql1 --network=ansible apasoft/debian11-ansible 
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --ip 172.18.0.11 --cgroupns=host --name=mysql2 --network=ansible apasoft/debian11-ansible
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --ip 172.18.0.12 --cgroupns=host --name=tomcat1 --network=ansible apasoft/debian11-ansible 
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --ip 172.18.0.13 --cgroupns=host --name=tomcat2 --network=ansible apasoft/debian11-ansible 

docker ps