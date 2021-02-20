#!/bin/bash
mkdir -p /opt/scripts/cloudflare
ln -s /opt/scripts/cloudflare cloudflare-ufw.sh
#upload cloudlfare-ufw.sh to git with the +x permission added and it will copy across
#chmod +x /opt/scripts/cloudflare/cloudflare-ufw.sh
#first run to create UFW entries UFW requires root/sudoers access for modification
sudo /opt/scripts/cloudflare/cloudflare-ufw.sh
#add entry to root crontab (UFW must use root to delete/add entries)
line="0 0 * * 1 /opt/scripts/cloudflare/cloudflare-ufw.sh > /dev/null 2>&1"
(sudo crontab -u root -l; echo "$line" ) | sudo crontab -u root -

