#SH-OTA v1.2_alpha By Deic & DiamondBond

#Edit from here
script="location/script"
ota_cloud="https://yoursite/ota.sh"
curl_cloud="https://yoursite/curl.sh"

#Don't edit from here
tmp="/data/local/tmp"
curl_ext="$EXTERNAL_STORAGE/Download/curl.sh"

run_ota(){
#clear
if [ -f /system/bin/curl ] || [ -f /system/xbin/curl ]; then
curl -k -L -o $tmp/ota.sh $ota_cloud #>/dev/null 2>&1
sleep 2
chmod 755 $tmp/ota.sh
$SHELL -c $tmp/ota.sh
safe_exit
else
echo
echo "curl & openssl binaries don't found."
am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $curl_cloud #>/dev/null 2>&1
install_curl
fi
}

install_curl(){
#clear
if [ -f $curl_ext ]; then
am force-stop com.android.browser
cp -rf $curl_ext $tmp/curl.sh
rm -rf $curl_ext
chmod 755 $tmp/curl.sh
$SHELL -c $tmp/curl.sh
run_ota
else
install_curl
fi
}

safe_exit(){
rm -rf $tmp/main.sh
mount -o remount,ro /system
mount -o remount,ro /data
$SHELL -c $script
exit
}

mount -o remount,rw /system
mount -o remount,rw /data
run_ota
