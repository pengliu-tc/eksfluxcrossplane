#!/bin/sh
set -e

echo "Cleaning up unmanaged pods and aws-node"

kubectl delete daemonset aws-node --namespace kube-system --ignore-not-found --wait

kubectl delete --namespace flux-system $(/bin/bash /sbin/k8s-unmanaged.sh)

# label nodes for AWS VPC CNI ip tables flushing
# see: https://docs.cilium.io/en/stable/gettingstarted/k8s-install-helm/
# => EKS => !Note => 2. Flush iptables rules added by VPC CNI 
kubectl label nodes --all iptables=notflushed

exit 0
