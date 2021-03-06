# CloudFlare_Subnets_to_UFW
The purpose of this script is to do the following: 
1. Immediately add subnets from the public Cloudflare lists here: https://www.cloudflare.com/ips/ to your UFW service
2. Then restrict those subnets to port 80 and 443. 
3. Create a cron job for the purpose of refreshing the list of subnets that CloudFlare uses once a week (you can adjust this in the script as you see fit) 

This script assumes the following: 
1. You have UFW installed and properly enabled
2. You do not currently have any rules allowing 80 or 443 as this would defeat the purpose of locking down to only allowing CF subnets
3. You are NOT running as root. (the script will make edits to the root user crontab, you will be prompted for your )
4. Example removal of previous 80/443 rules:
 a. sudo ufw delete allow 443
 b. sudo ufw delete allow 80 
 
#How to install 
1. git clone https://github.com/haljordan2814/CloudFlare_Subnets_to_UFW
2. cd CloudFlare_Subnets_to_UFW
3. chmod +x installCFtoUFW.sh
4. ./installCFtoUFW.sh
5. The only prompt you will need to respond to is your current user password (must be sudo enabled) for the root crontab entry. 
 
Credit where credit is due:
1. Leow Kah Man THE original reason for this script to even exist https://www.leowkahman.com/2016/05/02/automate-raspberry-pi-ufw-allow-cloudflare-inbound/

2. Edit root crontab (needed for UFW) https://unix.stackexchange.com/questions/127732/system-crontab-or-root-crontab

3. Utilize root and prompt for root password in script https://stackoverflow.com/a/36603412/15245545

4. Sort and identify specific UFW rules (we are grep'ing via comment; specifically "Cloudflare" https://serverfault.com/a/930830/618240

5. Cron documentation. We are refreshing UFW Cloudflare ruleset once a week https://support.acquia.com/hc/en-us/articles/360004224494-Cron-time-string-format

6. Quickly add a line to the end of the crontab. I modified this to add to root crontab: https://askubuntu.com/a/58582/627943

7. Cronitor: I utilized cronitor to troubleshoot my cron additions: https://unix.stackexchange.com/a/547958/457011 https://cronitor.io/docs/using-cronitor-cli (Remember in this case to run this command as the root user, UFW run in the root crontab) 

8. 
