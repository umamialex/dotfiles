#!/bin/bash

. ./apt-init/log.sh && \

./apt-init/update.sh && \

./apt-init/installers/aptitude.sh && \
./apt-init/installers/core.sh && \

./apt-init/prerequisites/fish.sh && \
./apt-init/prerequisites/node.sh && \
./apt-init/prerequisites/vim.sh && \

./apt-init/update.sh && \
./apt-init/upgrade.sh && \

./apt-init/installers/dev.sh && \
./apt-init/installers/config.sh && \
./apt-init/installers/npm.sh && \
./apt-init/installers/mongodb.sh && \
./apt-init/installers/gcloud.sh && \
./apt-init/installers/docker.sh && \

./apt-init/fix-permissions.sh && \

# Set fish as default shell
log "Setting fish as default shell:" && \
echo "" >> /home/$USER/.bashrc && \
echo "fish; exit" >> /home/$USER/.bashrc && \

./apt-init/update-sudoers.sh && \
./apt-init/update-defaults.sh && \

log "Done!"
