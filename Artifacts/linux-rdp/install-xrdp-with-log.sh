#!/bin/sh
/bin/sh install-xrdp.sh "$@" 2>&1 | install -D /dev/stdin /var/log/azure-dtl-artifacts/linux-rdp.log