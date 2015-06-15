#SH-OTA v1.2_wip By Deic & DiamondBond

if [ ! -f /system/bin/curl ] || [ ! -f /system/xbin/curl ] || [ ! -f /sbin/curl ]
then
curl -k -L curlurl | sh
else
curl -k -L otaurl | sh
fi
