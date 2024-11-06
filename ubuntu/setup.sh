#!/bin/bash

. ./ubuntu/scripts/log.sh && \

./ubuntu/scripts/update.sh && \

./ubuntu/scripts/installers/aptitude.sh && \
./ubuntu/scripts/installers/core.sh && \

./ubuntu/scripts/repositories/fish.sh && \
./ubuntu/scripts/repositories/node.sh && \
./ubuntu/scripts/repositories/yarn.sh && \
./ubuntu/scripts/repositories/kubectl.sh && \
./ubuntu/scripts/repositories/helm.sh && \

./ubuntu/scripts/update.sh && \

if [[ "$CI" != "true" ]]; then
  ./ubuntu/scripts/upgrade.sh
fi && \

./ubuntu/scripts/installers/dev.sh && \
./ubuntu/scripts/installers/config.sh && \
./ubuntu/scripts/installers/yarn-global.sh && \
./ubuntu/scripts/installers/pip.sh && \

# Set fish as default shell
log "Setting fish as default shell:" && \
echo "" >> /home/$USER/.bashrc && \
echo "fish; exit" >> /home/$USER/.bashrc && \

./ubuntu/scripts/update-sudoers.sh && \

if [[ "$CI" != "true" ]]; then
  ./ubuntu/scripts/update-defaults.sh && \
  sudo --preserve-env=HOME -u $USER ./ubuntu/scripts/installers/git.sh
fi && \

log "Done!"
