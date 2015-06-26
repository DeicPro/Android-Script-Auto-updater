SH-OTA(){#v1.2_alpha By Deic
#Edit values
name="your_script.sh"
version="version"
location="/system/xbin"
cloud="https://your_site.com/ota.sh"

#Don't edit
ext="$EXTERNAL_STORAGE/Download"
tmp="/data/local/tmp"
xbin="/system/xbin"
ssl="/data/local/ssl"
mount_rw="mount -o remount,rw "
mount_ro="mount -o remount,ro "
curl_cloud="https://github.com/DeicPro/Download/releases/download/curl"
start_browser="am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $curl_cloud"

$mount_rw/system
$mount_rw/data

if [ ! -f $xbin/curl ]
then
clear
echo "Curl binaries not found."
sleep 1
clear
echo "Downloading curl binaries..."
sleep 1
$start_browser/curl.file >/dev/null 2>&1
$start_browser/openssl.file >/dev/null 2>&1
$start_browser/openssl_cnf.file >/dev/null 2>&1
$start_browser/ca-bundle_crt.file >/dev/null 2>&1
curl="1"
fi

if [ "$curl" == 1 ]
then
while true
do
if [ -f $ext/curl.file ] && [ -f $ext/openssl.file ]
then
if [ -f $ext/openssl_cnf.file ] && [ -f $ext/ca-bundle_crt.file ]
then
clear
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
clear
echo "Installed."
sleep 1
break
fi
fi
done
fi

if [ ! "$curl" ]
then
clear
echo "Checking updates..."
sleep 1
curl -kLo $tmp/ota.sh $cloud >/dev/null 2>&1
while true
do
if [ -f $tmp/ota.sh ]
then
chmod 755 $tmp/ota.sh
$tmp/ota.sh
break
fi
done
fi

while true
do
if [ -f $tmp/$name ]
then
clear
echo "Installing..."
sleep 1
cp -f $tmp/$name $location/$name
rm -f $tmp/$name
chmod 755 $location/$name
clear
echo "Installed."
sleep 1
$mount_ro/system 2>/dev/null
$mount_ro/data 2>/dev/null
$location/$name
clear
exit
fi
done
}

SH-OTA
