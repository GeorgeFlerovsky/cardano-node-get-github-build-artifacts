#!/bin/bash

# Not sure how to properly update this. Keep it hard-coded for now.
node_build_number=6510764

# ====================================================================================
# Download and extract the build artifacts into the node's bin folder

# Ensure that the `bin` directory exists.
[ -d $NODE_CONFIG_DIR ] || mkdir -p $NODE_CONFIG_DIR

cd $NODE_CONFIG_DIR

for file in config byron-genesis shelley-genesis alonzo-genesis topology
  do echo $file
    curl -L -O "https://hydra.iohk.io/build/${node_build_number}/download/1/${NODE_TYPE}-${file}.json"
  done

