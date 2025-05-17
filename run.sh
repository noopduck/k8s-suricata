#!/bin/bash

# Define volume paths (create them if they don't exist)
mkdir -p ./etc-suricata ./var-log ./var-lib

# Extract rules data from suricata allowing suricata engine to start
docker run -d --name suricata suricata:latest
docker cp suricata:/usr/local/var/lib/suricata var-lib/.
docker container stop suricata
yes | docker container rm suricata

# Run the container with proper capabilities and network access
docker run --rm -it \
  --name suricata \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  --cap-add=SYS_NICE \
  --net=host \
  -v "$(pwd)/etc-suricata:/usr/local/etc/suricata" \
  -v "$(pwd)/var-log:/usr/local/var/log/suricata" \
  -v "$(pwd)/var-lib:/usr/local/var/lib/suricata" \
  suricata:latest $@
