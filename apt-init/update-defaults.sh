#!/bin/bash

. ./apt-init/log.sh && \

log "[MANUAL] Updating default editor:" && \
update-alternatives --config editor
