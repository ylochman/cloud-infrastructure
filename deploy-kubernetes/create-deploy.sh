#!/bin/sh

# Options:
# -m 	Start minikube first
# -l 	Deploy an application from local image
# -b 	Build an image locally before running (can be used only with -l)

deploymentFile=deployment-cloud.yaml

while getopts ":mlb" opt; do
  case $opt in
    m) minikube start; kubectl config use-context minikube;;
	l) echo 'Deploying from local image'; deploymentFile=deployment-local.yaml;;
	b) eval $(minikube docker-env); docker build -t ylochman-hw:local ..;;
    \?) echo "Invalid option: -$OPTARG" >&2;;
  esac
done

kubectl create -f $(deploymentFile)
# kubectl run ylochman-hw --image=ylochman-hw:local --port=5000 --image-pull-policy=Never

kubectl rollout status deployment.apps/ylochman-hw -w

kubectl create -f deployment-service.yaml
# kubectl expose deployment ylochman-hw --port=5000 --target-port=5000 --type=NodePort

echo \> Go to application: $(minikube service ylochman-hw --url)