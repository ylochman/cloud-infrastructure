#!/bin/sh
################################################
# Description:
#	Deletes Deployment, Service & Horizontal Pod Autoscaler in Minikube
# Options:
# -m 	Stop minikube at the end
################################################

kubectl delete services ylochman-hw-service

kubectl delete deployment ylochman-hw

kubectl delete hpa ylochman-hw-autoscaling

while getopts ":m" opt; do
  case $opt in
    m) minikube stop;;
    \?) echo "Invalid option: -$OPTARG" >&2;;
  esac
done