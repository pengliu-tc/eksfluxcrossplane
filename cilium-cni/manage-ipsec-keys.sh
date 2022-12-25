#!/bin/sh
set -e

# Somehow the ultimate-cli image uses proxy to access the cluster
unset https_proxy HTTPS_PROXY
unset http_proxy HTTP_PROXY

kubectl patch secret -n kube-system cilium-ipsec-keys --patch="{\"metadata\": { \"annotations\": { \"kustomize.toolkit.fluxcd.io/reconcile\": \"disabled\" }}, \"stringData\": { \"keys\": \"3 rfc4106(gcm(aes)) $(echo $(dd if=/dev/urandom count=20 bs=1 2> /dev/null | xxd -p -c 64)) 128\" }}"
# Should close https://icorp.jaas.service.deutschebahn.com/browse/DBCSKCS-3258
kubectl rollout restart daemonset -n kube-system cilium

exit 0
