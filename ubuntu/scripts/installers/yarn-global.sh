#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Install corepack:" && \

env COREPACK_ENABLE_DOWNLOAD_PROMPT=0 corepack enable && \

log "Install global yarn packages:" && \

yarn global add \
  babel-eslint \
  eslint \
  eslint-config-airbnb \
  eslint-plugin-import \
  eslint-plugin-jsx-a11y \
  eslint-plugin-react \
  ngrok \
  typescript
