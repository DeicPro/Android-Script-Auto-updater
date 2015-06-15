#SH-OTA v1.2_alpha By Deic & DiamondBond

cloud="https://www.yoursite.com/yourota

tmp="/data/local/tmp"
url="https://github.com/DeicPro/curl/releases/download/curl"
xbin="/system/xbin"
ssl="/data/local/ssl"

curl -k -L -o $tmp/curl $url/curl
curl -k -L -o $tmp/openssl $url/openssl
curl -k -L -o $tmp/openssl.cnf $url/openssl.cnf
curl -k -L -o $tmp/ca-budle.crt $url/ca-budle.crt
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

curl -k -L $cloud | sh
exit
