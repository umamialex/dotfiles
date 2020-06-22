#!/bin/bash

. ./apt-init/log.sh && \

./apt-init/update.sh && \

./apt-init/installers/aptitude.sh && \
./apt-init/installers/core.sh && \

./apt-init/prerequisites/fish.sh && \
./apt-init/prerequisites/node.sh && \
./apt-init/prerequisites/vim.sh && \
./apt-init/prerequisites/yarn.sh && \

./apt-init/update.sh && \

if [[ "$CI" != "true" ]]; then
  ./apt-init/upgrade.sh
fi && \

./apt-init/installers/dev.sh && \
./apt-init/installers/config.sh && \
./apt-init/installers/mongodb.sh && \
./apt-init/installers/yarn-global.sh && \

./apt-init/fix-permissions.sh && \
./apt-init/setup-services.sh && \

# Set fish as default shell
log "Setting fish as default shell:" && \
echo "" >> /home/$USER/.bashrc && \
echo "fish; exit" >> /home/$USER/.bashrc && \

./apt-init/update-sudoers.sh && \

if [[ "$CI" != "true" ]]; then
  ./apt-init/update-defaults.sh
fi && \

log "Done!"
