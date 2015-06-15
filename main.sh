#SH-OTA v1.2_alpha By Deic & DiamondBond

#Edit from here
script="location of your script"
ota_cloud="link to ota.sh"
curl_cloud="link to curl.sh"

#Don't edit from here
curl_ext="$EXTERNAL_STORAGE/Download/curl.sh"
curl_tmp="/data/local/tmp/curl.sh"
mount=`mount-o remount`

clear
$mount,rw /system
$mount,rw /data

if [ ! -f /system/bin/curl ] || [ ! -f /system/xbin/curl ]
then
echo
echo "curl & openssl binaries don't found."
am start com.android.browser $curl_cloud
install
else
curl -k -L $ota_cloud | sh
fi

install(){
clear
if [ -f $curl_ext ]
then
am force-stop com.android.browser
cp -rf $curl_ext $curl_tmp
chmod 755 $curl_tmp
$SHELL -c $curl_tmp
else
install
fi
}

$mount,ro /system
$mount,ro /data
$SHELL -c $script

exit
