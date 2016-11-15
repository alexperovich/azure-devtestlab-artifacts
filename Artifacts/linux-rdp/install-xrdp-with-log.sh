#!/bin/sh
/bin/sh -v install-xrdp.sh "$@" 2>&1 | install -D /dev/stdin /var/log/azure-dtl-artifacts/linux-rdp.log