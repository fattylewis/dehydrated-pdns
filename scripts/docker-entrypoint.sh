#!/bin/bash

export INSTALL_PATH="/home/dehydrated/"

/usr/local/bin/gen_config.sh

cd $INSTALL_PATH
chmod +x /home/dehydrated/dehydrated
env DEBUG=true /home/dehydrated/dehydrated --accept-terms -c -x