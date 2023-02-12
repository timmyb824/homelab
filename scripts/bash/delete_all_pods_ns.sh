#!/usr/bin/env bash

NAMESPACE="wazuh"

for POD in $(kubectl get pods --no-headers -o custom-columns=":metadata.name" -n ${NAMESPACE})
do
        kubectl delete pod $POD --grace-period=0 --force --namespace ${NAMESPACE}
done