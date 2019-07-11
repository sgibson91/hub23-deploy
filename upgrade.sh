#!/bin/bash

# Initialise helm
helm init --client-only

# Make sure the JupyterHub/BinderHub Helm Chart repo is installed and up-to-date
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart
helm repo update
# Update local chart
cd hub23-chart && helm dependency update && cd ..

helm upgrade hub23 ./hub23-chart -f ./deploy/prod.yaml -f ./.secret/prod.yaml
echo
kubectl get pods -n hub23
echo
echo "Binder IP (binder.hub23.turing.ac.uk): " `kubectl get svc binder -n hub23 | awk '{ print $4}' | tail -n 1`
