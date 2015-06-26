SH-OTA(){#v1.2_alpha By Deic
#Edit values
name="your_script.sh"
version="version"
location="/system/xbin"
cloud="https://your_site.com/ota.sh"

#Don't edit
ext="$EXTERNAL_STORAGE/Download/curl.zip"
ssl="/data/local/ssl"
xbin="/system/xbin"
ota="/tmp/ota.sh"
tmp="/tmp/$name"
script="$location/$name"
mount_rw="mount -o remount,rw"

$mount_rw rootfs
$mount_rw /system
$mount_rw /data
mkdir -p /tmp/
chmod 755 /tmp/

if [ ! -f $xbin/curl ]
then clear
echo "Curl binaries not found."
sleep 1
clear
echo "Downloading curl binaries..."
sleep 1
am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity https://goo.gl/K0C2Mq >/dev/null 2>&1
curl="1"
fi

if [ "$curl" == 1 ]
then while true
do if [ -f $ext ]
then clear
echo "Installing..."
sleep 1
am force-stop com.android.browser
unzip -oq $ext -d /tmp/
cp -f /tmp/xbin/ $xbin/
cp -f /tmp/ssl/ $ssl/
chmod -R 755 $ssl/
chmod 755 $xbin/curl
chmod 755 $xbin/openssl
rm -f $ext
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
