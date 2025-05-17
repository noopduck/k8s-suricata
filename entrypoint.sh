#!/bin/bash

chown -R suricata /usr/local/etc
chown -R suricata /usr/local/var/

/usr/local/bin/suricata-update -c /usr/local/etc/suricata/suricata.yaml

/usr/local/bin/suricata -c /usr/local/etc/suricata/suricata.yaml --user suricata -i eth0
