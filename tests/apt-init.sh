#!/bin/bash

go version && \

node -v && \
npm -v && \
yarn -v &&\

expo --version && \
eslint --version && \
feathers --version && \
ngrok --version && \

cassandra -v && \
redis-cli --version && \
redis-server --version && \
mongod --version && \

fish -v && \
vim --version && \
tmux -V && \
ag --version && \
htop --version && \
git --version
