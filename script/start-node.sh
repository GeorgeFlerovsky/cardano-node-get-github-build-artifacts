#!/bin/bash
PORT=6000
HOSTADDR=0.0.0.0
DB_PATH=${NODE_HOME}/db
CONFIG=${NODE_CONFIG_DIR}/alonzo-blue-config.json
TOPOLOGY=${NODE_CONFIG_DIR}/alonzo-blue-topology.json

cd $NODE_HOME

cardano-node run --topology ${TOPOLOGY} --database-path ${DB_PATH} --socket-path ${CARDANO_NODE_SOCKET_PATH} --host-addr ${HOSTADDR} --port ${PORT} --config ${CONFIG} > node.log


##!/bin/bash

#DIRECTORY=/home/george/.toolbox/cardano_node/projects/cardano_node
#PORT=6000
#HOSTADDR=0.0.0.0
#TOPOLOGY=${DIRECTORY}/configuration/alonzo-blue/alonzo-blue-topology.json
#DB_PATH=${DIRECTORY}/db
#SOCKET_PATH=${DIRECTORY}/db/socket
#CONFIG=${DIRECTORY}/configuration/alonzo-blue/alonzo-blue-config.json
#cardano-node run --topology ${TOPOLOGY} --database-path ${DB_PATH} --socket-path ${SOCKET_PATH} --host-addr ${HOSTADDR} --port ${PORT} --config ${CONFIG} > node.log
