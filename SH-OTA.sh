#SH-OTA v1.2_alpha By Deic

#Edit values
s_name="your_script.sh"
s_version="version"
s_location="/system/xbin"
s_cloud="https://your_site.com/ota.sh"

#Don't edit
s_mount_rw="mount -o remount,rw"
s_info=/tmp/SH-OTA.info
s_ext="$EXTERNAL_STORAGE/Download/curl.zip"
s_ssl="/data/local/ssl"
s_certs="$s_ssl/certs/"
s_xbin="/system/xbin"
s_ota="/tmp/ota.sh"
s_tmp="/tmp/$s_name"
s_script="$s_location/$s_name"

$s_mount_rw rootfs
$s_mount_rw /system
$s_mount_rw /data
mkdir -p /tmp/
chmod 755 /tmp/
touch $s_info

if [ ! -f $s_xbin/curl ]
then clear
echo "Curl binaries not found."
sleep 1
clear
echo "Downloading curl binaries..."
sleep 1
am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity https://github.com/DeicPro/Download/releases/download/curl/curl.zip >/dev/null 2>&1
s_curl="1"
fi

if [ "$s_curl" == 1 ]
then while true
do if [ -f $s_ext ]
then am force-stop com.android.browser
#clear
echo "Installing..."
sleep 1
unzip -oq $s_ext -d /tmp/
break
fi
done

while true
do if [ -f /tmp/curl ] && [ -f /tmp/openssl/ ] && [ -f /tmp/openssl.cnf ] && [ -f /tmp/ca-bundle.crt ]
then mkdir $s_ssl/
mkdir $s_certs/
cp -f /tmp/curl $s_xbin/
cp -f /tmp/openssl $s_xbin/
cp -f /tmp/openssl.cnf $s_ssl/
cp -f /tmp/ca-bundle.crt $s_certs/
chmod 755 $s_xbin/curl
chmod 755 $s_xbin/openssl
chmod -R 755 $s_ssl/
rm -f $s_ext
break
fi
done

while true
do if [ -f $s_xbin/curl ] && [ -f $s_xbin/openssl ] && [ -d $s_ssl/ ]
then clear
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
