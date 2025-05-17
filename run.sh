#!/bin/bash

# Define volume paths (create them if they don't exist)
mkdir -p ./etc-suricata ./var-log ./var-lib

# Run the container with proper capabilities and network access
docker run --rm -it \
  --name suricata \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  --net=host \
  -v "$(pwd)/etc-suricata:/usr/local/etc/suricata" \
  -v "$(pwd)/var-log:/usr/local/var/log/suricata" \
  -v "$(pwd)/var-lib:/usr/local/var/lib/suricata" \
  suricata:latest $@
