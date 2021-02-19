#! /bin/bash
mkdir /opt/scripts/cloudflare
cp cloudflare-ufw.sh /opt/scripts/cloudflare/
chmod +x /opt/scripts/cloudflare/cloudflare-ufw.sh
#first run to create UFW entries UFW requires root/sudoers access for modification
read -s -p "Enter Password for sudo: " sudoPW
echo $sudoPW | sudo /opt/scripts/cloudflare/cloudflare-ufw.sh
#add entry to root crontab (UFW must use root to delete/add entries)
line="0 0 * * 1 /opt/scripts/cloudflare/cloudflare-ufw.sh > /dev/null 2>&1"
(sudo crontab -u root -l; echo "$line" ) | sudo crontab -u root -

