#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Adding kubectl signing key:" && \
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --always-trust --dearmor --batch --yes -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \

log "Adding kubectl repo:" && \
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
