SH-OTA(){#v1.2_alpha By Deic
#Edit values
name="your_script.sh"
version="version"
location="/system/xbin"
cloud="https://your_site.com/ota.sh"

#Don't edit
ext="$EXTERNAL_STORAGE/Download"
ssl="/data/local/ssl"
xbin="/system/xbin"
ota="/tmp/ota.sh"
tmp="/tmp/$name"
script="$location/$name"
mount_rw="mount -o remount,rw"
curl_cloud="https://goo.gl/K0C2Mq"

$mount_rw rootfs
$mount_rw /system
$mount_rw /data
mkdir -p /tmp/

if [ ! -f $xbin/curl ]
then clear
echo "Curl binaries not found."
sleep 1
clear
echo "Downloading curl binaries..."
sleep 1
am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $curl_cloud >/dev/null 2>&1
curl="1"
fi

if [ "$curl" == 1 ]
then while true
do if [ -f $ext/curl.zip ]
then clear
echo "Installing..."
sleep 1
am force-stop com.android.browser
cp -f $ext/curl.zip /tmp/
unzip -oq /tmp/curl.zip -d /tmp/
cp -f /tmp/xbin/ $xbin/
cp -f /tmp/ssl/ $ssl/
chmod -R 755 $ssl/
chmod 755 $xbin/curl
chmod 755 $xbin/openssl
clear
echo "Installed."
sleep 1
break
fi
fi
done
fi

clear
echo "Checking updates..."
sleep 1
curl -klos $ota $cloud

while true
do if [ -f $ota ]
then chmod 755 $ota.sh
$ota.sh
break
fi
done

while true
do if [ -f $tmp ]
then clear
echo "Installing..."
sleep 1
cp -f $tmp $script
rm -f $tmp
chmod 755 $script
clear
echo "Installed."
sleep 1
$script
clear
exit
fi
done
}

SH-OTA
