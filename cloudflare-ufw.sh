#!/bin/sh
#assure cleanup of any prior 80/443 rules, we will search and match on commented lines containing Cloudflare
for NUM in $(ufw status numbered | grep Cloudflare | awk -F"[][]" '{print $2}' | tr --delete [:blank:] | sort -rn); do
    yes | ufw delete $NUM
done
#Edit the various sections to suit your needs here. Most examples pertain to IPv4/6 and/or ports
#This script assumes you currently do NOT have 80/443 allowed. 
#Remember the intent is to only allow 80/443 from CF originating IP addresses or any other ports you desire 
curl -s https://www.cloudflare.com/ips-v4 -o /tmp/cf_ips
#curl -s https://www.cloudflare.com/ips-v6 >> /tmp/cf_ips

# Allow all traffic from Cloudflare IPs (no ports restriction)
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip comment 'Cloudflare IP'; done

ufw reload > /dev/null

# OTHER EXAMPLE RULES
# Retrict to port 80
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 80 comment 'Cloudflare IP'; done

# Restrict to port 443
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 443 comment 'Cloudflare IP'; done

# Restrict to ports 80 & 443
for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 80,443 comment 'Cloudflare IP'; done
