#!/bin/sh

#### DECLARE VARIABLES
SwarmManagerName=myvm1
declare -a SwarmWorkers=("myvm2")

#### STOP APPLICATION
docker stack rm ylochman-app

### REMOVE SWARM
for SwarmWorkerName in "${SwarmWorkers[@]}"
do
	eval $(docker-machine env $SwarmWorkerName)
	docker swarm leave --force
done
eval $(docker-machine env $SwarmManagerName)
docker swarm leave --force

eval $(docker-machine env -u)

### REMOVE VMs
# for SwarmWorkerName in "${SwarmWorkers[@]}"
# do
	# docker-machine rm $SwarmWorkerName -f
# done
# docker-machine rm $SwarmManagerName -f