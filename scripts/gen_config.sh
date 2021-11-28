#!/bin/bash
set -e

gen_config_file() {
    echo ">>>>> Generating config <<<<<<<"
    cd /home/dehydrated
    cat <<EOF >> config

PDNS_HOST=${PDNS_HOST}
PDNS_PORT=${PDNS_PORT}
PDNS_KEY=${PDNS_KEY}
PDNS_SERVER=${PDNS_SERVER}
PDNS_VERSION=${PDNS_VERSION}
PDNS_WAIT=${PDNS_WAIT}
PDNS_ZONES_TXT=/home/dehydrated/zones.txt
PDNS_NO_NOTIFY=yes
CHALLENGETYPE="dns-01"
HOOK=/home/dehydrated/hook.sh
HOOK_CHAIN="yes"
LOCKFILE=/tmp/lock
CHAINCACHE=/chains
CERTDIR=/certs
ACCOUNTDIR=/accounts
DOMAINS_TXT=/home/dehydrated/domains.txt
EOF
}

gen_config_file
