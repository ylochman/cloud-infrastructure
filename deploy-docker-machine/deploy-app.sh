#!/bin/sh
# To-do:
# [ ] flag for creating VMs + args for manager and workers names

#### DECLARE VARIABLES
SwarmManagerName=myvm1
declare -a SwarmWorkers=("myvm2")

#### CREATE VMs
# for SwarmWorkerName in "${SwarmWorkers[@]}"
# do
# 	docker-machine create --driver virtualbox $SwarmWorkerName
# done
# docker-machine create --driver virtualbox $SwarmManagerName

#### INIT SWARM
SwarmManagerURL=$(docker-machine ls --filter name=$SwarmManagerName -f {{.URL}})
SwarmManagerIP=$(echo $SwarmManagerURL| cut -d':' -f 2| cut -d'/' -f 3)
echo Manager: $SwarmManagerName \($SwarmManagerIP\)

eval $(docker-machine env $SwarmManagerName)
docker swarm init --advertise-addr $SwarmManagerIP
SwarmWorkerToken=$(docker swarm join-token -q worker)

#### CREATE WORKERS + JOI./N SWARM

for SwarmWorkerName in "${SwarmWorkers[@]}"
do
	SwarmWorkerURL=$(docker-machine ls --filter name=$SwarmWorkerName -f {{.URL}})
	SwarmWorkerIP=$(echo $SwarmWorkerURL| cut -d':' -f 2| cut -d'/' -f 3)
	echo Worker: $SwarmWorkerName \($SwarmWorkerIP\)

	eval $(docker-machine env $SwarmWorkerName)
	docker swarm join --token $SwarmWorkerToken $SwarmManagerIP:2377
done

#### DEPLOY (START) APPLICATION
eval $(docker-machine env $SwarmManagerName)
docker stack deploy -c docker-compose.yml ylochman-app

echo \> Go to application: http://$SwarmManagerIP:5000
echo \> Visualize cluster: http://$SwarmManagerIP:8080