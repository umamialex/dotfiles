#!/bin/bash

. ./ubuntu/scripts/git-clone.sh && \

clone athletesgg/agg-app yarn
clone athletesgg/agg-daemon yarn
clone athletesgg/agg-ms-api yarn
clone athletesgg/agg-sdk yarn

clone grafana/backend-enterprise
clone grafana/cortex-jsonnet
clone grafana/customers
clone grafana/deployment_tools
clone grafana/helm-charts
clone grafana/proserv-training-demo
clone grafana/website
