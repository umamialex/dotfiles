#!/bin/bash

. ./apt-init/log.sh && \

log "Add Helm signing key:" && \
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add - && \

log "Add Helm repository:" && \
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
