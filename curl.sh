#SH-OTA v1.2_alpha By Deic & DiamondBond

#Don't edit
ext="$EXTERNAL_STORAGE/Download/"
xbin="/system/xbin"
ssl="/data/local/ssl"
curl_cloud="https://github.com/DeicPro/Download/releases/download/curl"
start_browser=`am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity`

download_curl(){
clear
echo
echo "Downloading curl binary..."
sleep 1

$start_browser $curl_cloud/curl.file >/dev/null 2>&1
echo
echo "Downloading openssl binary..."
sleep 1

$start_browser $curl_cloud/openssl.file >/dev/null 2>&1
$start_browser $curl_cloud/openssl_cnf.file >/dev/null 2>&1
$start_browser $curl_cloud/ca-bundle_crt.file >/dev/null 2>&1
install_curl
}

install_curl(){
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
rm -f /data/local/tmp/curl.sh
exit
else
install_curl
fi
}

download_curl
