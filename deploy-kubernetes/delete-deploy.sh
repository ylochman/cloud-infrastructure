#!/bin/sh
################################################
# Description:
#	Deletes Deployment, Service in Minikube
# Options:
# -m 	Stop minikube at the end
################################################

kubectl delete services ylochman-hw-service
kubectl delete deployment ylochman-hw

# kubectl delete $(kubectl get all  | grep ylochman | awk '{print $1}')

while getopts ":m" opt; do
  case $opt in
    m) minikube stop;;
    \?) echo "Invalid option: -$OPTARG" >&2;;
  esac
done