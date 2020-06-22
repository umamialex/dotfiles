#!/bin/bash

. ./apt-init/log.sh && \

log "Downloading GoLang 1.14.4:" && \
wget -O go.tar.gz "https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz" && \

log "Installing GoLang:" && \
sudo tar -C /usr/local -xzf go.tar.gz && \
rm go.tar.gz
