#!/bin/bash

. ./apt-init/log.sh && \

log "Install global yarn packages:" && \

yarn global add \
  babel-eslint \
  eslint \
  eslint-config-airbnb \
  eslint-plugin-import \
  eslint-plugin-jsx-a11y \
  eslint-plugin-react \
  ngrok \
  pm2 \
  n \
  expo-cli \
  @feathersjs/cli
