#SH-OTA v1.2_alpha By Deic & DiamondBond

#Don't edit from here
tmp="/data/local/tmp"
xbin="/system/xbin"
ssl="/data/local/ssl"
curl_cloud="https://github.com/DeicPro/curl/releases/download/curl"
start_browser=`am start com.android.browser`
stop_browser`am force-stop com.android.browser

$start_browser $tmp/curl $curl_cloud/curl
$start_browser $tmp/openssl $curl_cloud/openssl
$start_browser $tmp/openssl.cnf $curl_cloud/openssl.cnf
$start_browser $tmp/ca-budle.crt $curl_cloud/ca-budle.crt
cp -rf $tmp/curl $xbin/
cp -rf $tmp/openssl $xbin/
mkdir -p $ssl/
mkdir -p $ssl/certs/
cp -rf $tmp/openssl.cnf $ssl/
cp -rf $tmp/ca-budle.crt $ssl/certs/
chmod 755 $xbin/curl
chmod 755 $xbin/openssl
chmod 755 $ssl/
chmod 755 $ssl/certs/
chmod 755 $ssl/openssl.cnf
chmod 755 $ssl/certs/ca-budle.crt

exit
