#SH-OTA v1.2_alpha By Deic & DiamondBond

sh-ota(){
	#Edit from here
	ota_cloud="https://your_site.com/ota.sh"
script="location/script"

	#Don't edit from here
ext="$EXTERNAL_STORAGE/Download/"
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
cp -f $ext/curl.file $xbin/curl
cp -f $ext/openssl.file $xbin/openssl
cp -f $ext/openssl_cnf.file $ssl/openssl.cnf
cp -f $ext/ca-bundle_crt.file $ssl/certs/ca-bundle.crt
rm -f $ext/curl.file
rm -f $ext/openssl.file
rm -f $ext/openssl_cnf.file
rm -f $ext/ca-bundle_crt.file
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
curl -k -L -o $tmp/ota.sh $ota_cloud >/dev/null 2>&1
while true; do
if [ -f $tmp/ota.sh ]; then
chmod 755 $tmp/ota.sh
$tmp/ota.sh
rm -f $tmp/ota.sh
mount -o remount,ro /system
mount -o remount,ro /data
$script
exit
fi
done
fi
}
sh-ota

#PENDING
#SH-OTA v1.2_alpha By Deic & DiamondBond

#Edit values
name="script" #Name of your script file
version="version" #Version of your script
location="location" #Location of your script
cloud="https://your_site.com/script" #Download link of your script

#Don't edit
tmp="/data/local/tmp/$name"
script="$location/$name"

install(){
clear
echo
echo "Downloading..."
sleep 1
curl -k -L -o $tmp $cloud >/dev/null 2>&1
while true; do
if [ -f $tmp ]; then
echo
echo "Installing..."
sleep 1
cp -f $tmp $script
rm -f $tmp
chmod 755 $script
echo
echo "Done."
sleep 1
clear
$script
exit
fi
done
}

clear
echo "Checking updates..."
sleep 1
if [ "`grep $version $script >/dev/null 2>&1`" ]; then
clear
echo "You have the latest version."
sleep 1
exit
fi
while true; do
clear
echo "A new version of the script was found..."
echo
echo "Want install it? (Y/N)"
echo
echo -n "> "
read install_ask_opt
case $install_ask_opt in
y|Y ) install;;
n|N ) exit;;
* ) echo "Write [Y] or [N] and press enter...";;
esac
done


