SH-OTA(){ #v2.0_alpha By Deic & hoholee12

#Edit values
version="version"
cloud="https://your_site.com/ota.sh"

#Not edit
mount_rw="mount -o remount,rw"
info=/tmp/SH-OTA.info
ext="$EXTERNAL_STORAGE/download/curl.zip"
ssl="/data/local/ssl"
certs="$ssl/certs/"
xbin="/system/xbin"
ota="/tmp/ota.sh"
#to be changed
tmp="/tmp/$name" #←
#to be changed

$mount_rw rootfs
$mount_rw /system
$mount_rw /data
mkdir -p /tmp/
chmod 755 /tmp/
touch $info

if [ ! -f $xbin/curl ]; then
	clear
	echo "Curl binaries not found."
	sleep 1
	clear
	echo "Downloading curl binaries..."
	am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity https://github.com/DeicPro/Download/releases/download/curl/curl.zip >/dev/null 2>&1
	curl="1"
fi

if [ "$curl" == 1 ]; then
	while true; do
		if [ -f $ext ]; then
			kill -9 $(pgrep com.android.browser)
			clear
			echo "Installing..."
			sleep 3
			unzip -oq $ext -d /tmp/
			break
		fi
	done

	while true; do
		if [ -f /tmp/curl ] && [ -f /tmp/openssl ] && [ -f /tmp/openssl.cnf ] && [ -f /tmp/ca-bundle.crt ]; then
			mkdir $ssl/
			mkdir $certs/
			cp -f /tmp/curl $xbin/
			cp -f /tmp/openssl $xbin/
			cp -f /tmp/openssl.cnf $ssl/
			cp -f /tmp/ca-bundle.crt $certs/
			sleep 2
			chmod -R 755 $xbin/
			chmod -R 755 $ssl/
			rm -f $ext
			break
		fi
	done

	while true; do
		if [ -f $xbin/curl ] && [ -f $xbin/openssl ] && [ -d $ssl/ ]; then
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
curl -k -L -o -s $ota $cloud

while true; do
	if [ -f $ota ]; then
		chmod 755 $ota
cat >> $ota <<EOF
custom_exit(){
echo "no" > /tmp/SH-OTA.info
exit
}

if [ "`grep script_version $0 2>/dev/null`" ]; then
clear
echo "You have the latest version."
sleep 1
custom_exit
fi

while true; do
clear
echo "A new version of the script was found..."
echo
echo "Want install it? (Y/N)"
echo
echo -n "> "
read install_opt
case $install_opt in
y|Y ) echo "yes" > /tmp/SH-OTA.info; break;;
n|N ) custom_exit;;
* ) echo "Write [Y] or [N] and press enter..."; sleep 1;;
esac
done

clear
echo "Downloading..."
sleep 1
curl -k -L -o -s $tmp $cloud
exit
EOF
sed -i 's/script_version/$version/' $ota
		$ota
		break
	fi
done

while true; do
	if [ "`grep no $info`" ]; then
		rm -rf /tmp/
		break
	fi

	if [ "`grep yes $info`" ]; then
		if [ -f $tmp ]; then
			clear
			echo "Installing..."
			cp -f $tmp $0
			sleep 2
			chmod 755 $0
			rm -rf /tmp/
			clear
			echo "Installed."
			sleep 1
			$SHELL -c $0
			clear
			exit
		fi
	fi
done
}
SH-OTA
