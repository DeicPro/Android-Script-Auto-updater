#SH-OTA v1.2_alpha By Deic

#Edit values
s_name="your_script.sh"
s_version="version"
s_location="/system/xbin"
s_cloud="https://your_site.com/ota.sh"

#Don't edit
s_info=/tmp/SH-OTA.info
s_ext="$EXTERNAL_STORAGE/Download/curl.zip"
s_ssl="/data/local/ssl"
s_xbin="/system/xbin"
s_ota="/tmp/ota.sh"
s_tmp="/tmp/$name"
s_script="$location/$name"
s_mount_rw="mount -o remount,rw"

$s_mount_rw rootfs
$s_mount_rw /system
$s_mount_rw /data
mkdir -p /tmp/
touch $s_info
chmod -R 755 /tmp/

if [ ! -f $s_xbin/curl ]
then clear
echo "Curl binaries not found."
sleep 1
clear
echo "Downloading curl binaries..."
sleep 1
am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity https://goo.gl/K0C2Mq >/dev/null 2>&1
curl="1"
fi

if [ "$s_curl" == 1 ]
then while true
do if [ -f $s_ext ]
then clear
echo "Installing..."
sleep 1
am force-stop com.android.browser
unzip -oq $s_ext -d /tmp/
cp -f /tmp/xbin/ $s_xbin/
cp -f /tmp/ssl/ $s_ssl/
chmod -R 755 $s_ssl/
chmod 755 $s_xbin/curl
chmod 755 $s_xbin/openssl
rm -f $s_ext
clear
echo "Installed."
sleep 1
break
fi
done
fi

clear
echo "Checking updates..."
sleep 1
curl -klos $s_ota $s_cloud

while true
do if [ -f $s_ota ]
then chmod 755 $s_ota.sh
$s_ota.sh
break
fi
done

then while true
do if [ "`grep no $s_info`" ]
then break
fi

if [ "`grep yes $s_info`" ]
then if [ -f $s_tmp ]
then clear
echo "Installing..."
sleep 1
cp -f $s_tmp $s_script
rm -f $s_tmp
chmod 755 $s_script
clear
echo "Installed."
sleep 1
$s_script
clear
exit
fi
fi
done
