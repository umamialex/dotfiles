#!/bin/bash

echo "Installing global npm modules..."

npm install -g \
  eslint \
  eslint-config-ctrl \
  eslint-config-ctrl-react \
  eslint-plugin-react \
  sass-lint \
  sass-lint-config-ctrl \
  pug-lint \
  pug-lint-config-ctrl \
  n

echo "Done"
