#!/bin/bash

. ./apt-init/log.sh && \

CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

log "Adding GCloud APT source:" && \
echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" \
  | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
&& \

log "Adding GCloud APT key:" && \
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \

log "Updating APT:" && \
apt-get update \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

log "Installing GCloud:" && \
apt-get install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -f \
  google-cloud-sdk
