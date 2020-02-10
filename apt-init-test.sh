#!/bin/bash

. ./apt-init/log.sh && \

./apt-init/update.sh && \

./apt-init/installers/aptitude.sh && \
./apt-init/installers/core.sh && \

./apt-init/prerequisites/fish.sh && \
./apt-init/prerequisites/node.sh && \
./apt-init/prerequisites/vim.sh && \
./apt-init/prerequisites/yarn.sh && \

aptitude hold \
  postgresql-common \
  postgresql-9.3 \
  postgresql-9.4 \
  postgresql-9.5 \
  postgresql-9.6 \
  postgresql-client-9.3 \
  postgresql-client-9.4 \
  postgresql-client-9.5 \
  postgresql-client-9.6 \
  postgresql-contrib-9.3 \
  postgresql-contrib-9.4 \
  postgresql-contrib-9.5 \
  postgresql-contrib-9.6 \
&& \

./apt-init/update.sh && \
./apt-init/upgrade.sh && \

./apt-init/installers/dev.sh && \
./apt-init/installers/config.sh && \
./apt-init/installers/docker.sh && \

./apt-init/fix-permissions.sh && \

# Set fish as default shell
log "Setting fish as default shell:" && \
echo "" >> /home/$USER/.bashrc && \
echo "fish; exit" >> /home/$USER/.bashrc && \

./apt-init/update-sudoers.sh && \

log "Done!"
