#!/bin/bash

SERVER_PORT="8000"

trap 'killall pool-node && killall pool-server' SIGINT SIGTERM

## spawn 100 peers
for port in {8001..8100}; do
  ./pool-node "tcp://127.0.0.1:${SERVER_PORT}" "tcp://*:${port}" &
done

sleep .5
./pool-server "tcp://*:${SERVER_PORT}"
