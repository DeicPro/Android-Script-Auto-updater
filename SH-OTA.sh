#SH-OTA v1.2_alpha By Deic

sh-ota(){
#Edit from here
name="your_script.sh"
version="version"
location="/system/xbin"
cloud="https://your_site.com/ota.sh"

#Don't edit from here
ext="$EXTERNAL_STORAGE/Download"
tmp="/data/local/tmp"
xbin="/system/xbin"
ssl="/data/local/ssl"
curl_cloud="https://github.com/DeicPro/Download/releases/download/curl"
start_browser="am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity"

mount -o remount,rw /system
mount -o remount,rw /data

clear
if [ ! -f $xbin/curl ]; then
echo "Downloading curl binary..."
sleep 1

$start_browser $curl_cloud/curl.file >/dev/null 2>&1

echo
echo "Downloading openssl binary..."; sleep 1

$start_browser $curl_cloud/openssl.file >/dev/null 2>&1
$start_browser $curl_cloud/openssl_cnf.file >/dev/null 2>&1
$start_browser $curl_cloud/ca-bundle_crt.file >/dev/null 2>&1

while true; do
if [ -f $ext/curl.file ] && [ -f $ext/openssl.file ] && [ -f $ext/openssl_cnf.file ] && [ -f $ext/ca-bundle_crt.file ]; then
echo
echo "Installing..."
sleep 1

am force-stop com.android.browser
mkdir -p $ssl/
mkdir -p $ssl/certs/
mv $ext/curl.file $xbin/curl
mv $ext/openssl.file $xbin/openssl
mv $ext/openssl_cnf.file $ssl/openssl.cnf
mv $ext/ca-bundle_crt.file $ssl/certs/ca-bundle.crt
chmod 755 $ssl/
chmod 755 $ssl/certs/
chmod 755 $xbin/curl
chmod 755 $xbin/openssl
chmod 755 $ssl/openssl.cnf
chmod 755 $ssl/certs/ca-bundle.crt

echo
echo "Done."
sleep 1

break
fi
done
else
clear
echo "Checking updates..."
sleep 1

curl -k -L -o $tmp/ota.sh $cloud >/dev/null 2>&1

while true; do
if [ -f $tmp/ota.sh ]; then
chmod 755 $tmp/ota.sh
$tmp/ota.sh

break
fi
done

while true; do
if [ -f $tmp/$name ]; then
echo
echo "Installing..."
sleep 1

mv $tmp/$name $location/$name
chmod 755 $location/$name

echo
echo "Done."
sleep 1

mount -o remount,ro /system
mount -o remount,ro /data

$location/$name

clear
exit
fi
done
fi
}
sh-ota
