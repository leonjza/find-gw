#!/bin/bash
#
# find-gw.sh
#   Check if you have a gateway that could get you somewhere nice.
#
# 2019 @leonjza
#
# This script uses the output of arp to find MAC addresses for
# potential gateways. It then runs nping to see if a target will
# respond to an icmp echo request.

TARGET=$1

if ! hash nping 2>/dev/null;then
    echo "[error] Could not find nping. Hint: It's part of nmap :)"
    exit 1
fi

if [ "$EUID" -ne 0 ];then 
  echo "nping will need root"
  exit 1
fi

if [ -z $1 ]; then
    echo "[info] Usage: $0 <target>"
    exit 1
fi

echo "[info] Trying ARP entries to reach $TARGET..."

for MAC in $(arp -a | cut -d ' ' -f4)
do
    # https://stackoverflow.com/a/19959688
    if [[ ! "$MAC" =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]];then
        continue
    fi

    grep RCVD <(nping -c 1 --icmp --dest-mac $MAC $TARGET) > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "[success] Could reach $TARGET via $MAC => $(grep $MAC <(arp -a))"
    fi
done

echo "[info] Done!"
