#!/bin/bash
################################################################################
# Enable line notify service and get token from https://notify-bot.line.me/en/
# To make script run on boot add /etc/rc.local
# #!/bin/bash -e
# /path-to-script/notifyip.sh
# Scripted by Hades
################################################################################
function sendline
{
curl --request POST \
  --url https://notify-api.line.me/api/notify \
  --header 'authorization: Bearer XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data "message=$1";
}

my_ip=$(ip route get 8.8.8.8 | awk '/8.8.8.8/ {print $NF}')
my_interface=$(ip route get 8.8.8.8 | awk '/dev/ {f=NR} f&&NR-1==f' RS=" ")
data="$my_interface:$my_ip"
echo $data
sendline $data

publicip=$(curl ipinfo.io/ip)
data="PublicIP:$publicip"
echo $data
sendline $data
