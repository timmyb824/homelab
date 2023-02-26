#!/usr/bin/env bash

read -p "Enter the namespace you want to delete all pods from: " NAMESPACE
read -p "Force delete all pods? (true/false): " FORCE_DELETE

# NAMESPACE="wazuh"
# FORCE_DELETE="false"

if [[ "$FORCE_DELETE" = "true" ]]; then
    echo "Force deleting all pods in namespace \"${NAMESPACE}\""
    for POD in $(kubectl get pods --no-headers -o custom-columns=":metadata.name" -n "${NAMESPACE}"); do
        kubectl delete pod "$POD" --grace-period=0 --force --namespace "${NAMESPACE}"
    done
    exit 0
elif [[ "$FORCE_DELETE" = "false" ]]; then
    echo "Deleting all pods in namespace \"${NAMESPACE}\""
    for POD in $(kubectl get pods --no-headers -o custom-columns=":metadata.name" -n "${NAMESPACE}"); do
        kubectl delete pod "$POD" --namespace "${NAMESPACE}"
    done
    exit 0
fi