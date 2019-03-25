#!/bin/sh

while getopts ":m" opt; do
  case $opt in
    m) minikube start; kubectl config use-context minikube;;
    \?) echo "Invalid option: -$OPTARG" >&2;;
  esac
done

kubectl run ylochman-hw --image=ylochman/apps-cloud-infra:latest --port=5000

kubectl rollout status deployment.apps/ylochman-hw -w

kubectl expose deployment ylochman-hw --port=5000 --target-port=5000 --type=NodePort
# type: ClusterIP, NodePort, LoadBalancer, or ExternalName

echo \> Go to application: $(minikube service ylochman-hw --url)