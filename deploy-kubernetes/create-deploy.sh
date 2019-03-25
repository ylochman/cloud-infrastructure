#!/bin/sh

# Options:
# -m 	Start minikube first
# -l 	Deploy an application from local image
# -b 	Build an image locally before running (can be used only with -l)

local=false

while getopts ":mlb" opt; do
  case $opt in
	m) minikube start; kubectl config use-context minikube;;
	l) local=true;;
	b) eval $(minikube docker-env); docker build -t ylochman-hw:local ..;;
    \?) echo "Invalid option: -$OPTARG" >&2;;
  esac
done

if [ "$local" = true ] ; then
    echo 'Deploying using local image'; deploymentFile=deployment-local.yaml
else
	echo 'Deploying using cloud registry'; deploymentFile=deployment-cloud.yaml
fi

# kubectl run ylochman-hw --image=ylochman-hw:local --replicas=5 --port=5000 --image-pull-policy=Never
# kubectl run ylochman-hw --image=ylochman/apps-cloud-infra:latest --replicas=3 --port=5000 --image-pull-policy=Always
# kubectl expose deployment ylochman-hw --port=5000 --target-port=5000 --type=LoadBalancer --name=ylochman-hw-service

kubectl create -f $deploymentFile
sleep 2
kubectl create -f deployment-service.yaml
sleep 5
# kubectl create -f deployment-autoscaling.yaml

# kubectl rollout status deployment.apps/ylochman-hw -w

echo \> Go to application: $(minikube service ylochman-hw-service --url)