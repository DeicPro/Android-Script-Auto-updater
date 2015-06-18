#SH-OTA v1.2_alpha By Deic & DiamondBond

#Don't edit from here
tmp="/data/local/tmp/"
xbin="/system/xbin/"
ssl="/data/local/ssl/"
curl_cloud="https://github.com/DeicPro/Downloads/releases/curl/"
start_browser=`am start -a android.intent.action.VIEW -n com.android.browser`

echo
echo "Downloading curl binary..."
sleep 1

$start_browser $curl_cloud/curl >/dev/null 2>&1
echo
echo "Downloading openssl binary..."
sleep 1

$start_browser $curl_cloud/openssl >/dev/null 2>&1
$start_browser $curl_cloud/openssl.cnf >/dev/null 2>&1
$start_browser $curl_cloud/ca-budle.crt >/dev/null 2>&1

install(){
if [ -f $tmp/curl ] && [ -f $tmp/openssl] && [ -f $tmp/openssl.cnf ] && [ -f $tmp/ca-bundle.crt]; then
echo
echo "Installing..."
sleep 1

am force-stop com.android.browser
mkdir -p $ssl/
mkdir -p $ssl/certs/
cp -rf $tmp/curl $xbin/
cp -rf $tmp/openssl $xbin/
cp -rf $tmp/openssl.cnf $ssl/
cp -rf $tmp/ca-bundle.crt $ssl/certs/
chmod 755 $ssl/
chmod 755 $ssl/certs/
chmod 755 $xbin/curl
chmod 755 $xbin/openssl
chmod 755 $ssl/openssl.cnf
chmod 755 $ssl/certs/ca-bundle.crt

echo
echo "Done."
sleep 1
else
install
fi
}

exit
