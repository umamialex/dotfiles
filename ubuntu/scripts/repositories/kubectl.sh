#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Adding kubectl signing key:" && \
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \

log "Adding kubectl repo:" && \
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
