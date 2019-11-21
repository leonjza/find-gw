# find-gw.sh

A bash script to check if you have a gateway that could get you somewhere nice.

## usage

First, make sure you have [`nping`](https://nmap.org/nping/).  
Next, download the script and run it. `nping` is going to want root for icmp, so use `sudo` or something similar.

```bash
curl -fsSL https://raw.githubusercontent.com/leonjza/find-gw/master/find-gw.sh -o find-gw.sh
# read the source code, right?
chmod +x find-gw.sh
sudo ./find-gw.sh 8.8.8.8
```

## example

```bash
$ sudo ./find-gw.sh 8.8.8.8
[info] Trying ARP entries to reach 8.8.8.8...
[success] Could reach 8.8.8.8 via xx:xx:xx:xx:xx:xx => gw.local (10.0.0.11) at xx:xx:xx:xx:xx:xx on eth0
[success] Could reach 8.8.8.8 via xx:xx:xx:xx:xx:xx => ap.local (10.0.0.20) at xx:xx:xx:xx:xx:xx on eth0
[info] Done!
```

## other

Sometimes, your ARP table won't have all of the entries availble on the LAN. Solve that by pinging a broadcast address. Assuming you are in a network like 192.168.5.0/24, try:

```bash
# Linux
ping -b 192.168.5.255

# macOS
ping 192.168.5.255
```
