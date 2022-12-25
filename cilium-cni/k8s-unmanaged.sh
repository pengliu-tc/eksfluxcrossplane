#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Copyright Authors of Cilium

function all_ceps { kubectl get cep --namespace flux-system -o json --selector='!job-name' | jq -r '.items[].metadata | "cep/" + .name'; }
function all_pods { kubectl get pods --namespace flux-system -o json --selector='!job-name' | jq -r '.items[] | select(.spec.hostNetwork==true | not) | .metadata | "pod/" + .name'; }
 
#echo "Skipping pods with host networking enabled..."

sort <(all_ceps) <(all_pods) | uniq -u
