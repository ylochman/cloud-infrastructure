#!/bin/sh

# -m: in the end stop minikube

# kubectl delete services ylochman-hw
# kubectl delete deployment ylochman-hw
kubectl delete $(kubectl get all  | grep ylochman | awk '{print $1}')

while getopts ":m" opt; do
  case $opt in
    m) minikube stop;;
    \?) echo "Invalid option: -$OPTARG" >&2;;
  esac
done