#!/bin/sh

# -m: first start minikube
# -b: build docker image locally before runing

while getopts ":mb" opt; do
  case $opt in
    m) minikube start; kubectl config use-context minikube;;
	b) eval $(minikube docker-env); docker build -t ylochman-hw:local ..;;
    \?) echo "Invalid option: -$OPTARG" >&2;;
  esac
done

kubectl run ylochman-hw --image=ylochman-hw:local --port=5000 --image-pull-policy=Never

kubectl rollout status deployment.apps/ylochman-hw -w

kubectl expose deployment ylochman-hw --port=5000 --target-port=5000 --type=NodePort
# type: ClusterIP, NodePort, LoadBalancer, or ExternalName

echo \> Go to application: $(minikube service ylochman-hw --url)