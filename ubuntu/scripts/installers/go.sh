#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Downloading GoLang 1.15.8:" && \
wget -O go.tar.gz "https://golang.org/dl/go1.15.8.linux-amd64.tar.gz" && \

log "Installing GoLang:" && \
sudo tar -C /usr/local -xzf go.tar.gz && \
rm go.tar.gz && \

log "Installing GoLang packages:" && \

if [[ "$CI" != "true" ]]; then
  log "Installing tk:" && \
  fish -c "go get github.com/grafana/tanka/cmd/tk" && \
  fish -c "tk --version" && \

  log "Installing logcli:" && \
  fish -c "go get github.com/grafana/loki/cmd/logcli" && \
  fish -c "logcli --version" && \

  log "Installing jsonnet:" && \
  fish -c "go get github.com/google/go-jsonnet/cmd/jsonnet" && \
  fish -c "jsonnet --version" && \

  log "Installing jb:" && \
  fish -c "go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb" && \
  fish -c "jb --version" && \

  log "Installing amtool:" && \
  fish -c "go get github.com/prometheus/alertmanager/cmd/amtool" && \
  fish -c "amtool --version"
fi
