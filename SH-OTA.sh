SH-OTA(){ #v2.0_alpha By Deic & hoholee12

#Edit values
version="version"
cloud="https://your_site.com/version.sh"

#Not edit
mount_rw="mount -o remount,rw"
ssl="/data/local/ssl"
certs="$ssl/certs/"
xbin="/system/xbin"
base_name=`basename $0`

$mount_rw rootfs
$mount_rw /system
$mount_rw /data
mkdir -p /tmp/
chmod 755 /tmp/
touch /tmp/SH-OTA.info

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
		if [ -f $EXTERNAL_STORAGE/download/curl.zip ]; then
			kill -9 $(pgrep com.android.browser)
			clear
			echo "Installing..."
			sleep 3
			unzip -oq $EXTERNAL_STORAGE/download/curl.zip -d /tmp/
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
			rm -f $EXTERNAL_STORAGE/download/curl.zip
			break
		fi
	done

	while true; do
		if [ -f $xbin/curl ] && [ -f $xbin/openssl ] && [ -f $ssl/openssl.cnf ] && [ -f $certs/ca-bundle.crt ]; then
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
curl -k -L -o /tmp/ota.sh $cloud 2>/dev/null

while true; do
	if [ -f /tmp/ota.sh ]; then
		chmod 755 /tmp/ota.sh
cat >> /tmp/ota.sh <<EOF
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
case script_install in
y|Y ) echo "yes" > /tmp/SH-OTA.info; break;;
n|N ) custom_exit;;
* ) echo "Write [Y] or [N] and press enter..."; sleep 1;;
esac
done

clear
echo "Downloading..."
sleep 1
curl -k -L -o /tmp/$base_name script_cloud 2>/dev/null
exit
EOF
		sed -i 's/script_version/$version/' $ota
		sed -i 's/script_install/$install_opt/' $ota
		sed -i 's/script_cloud/$cloud/' $ota
		$SHELL -c /tmp/ota.sh
		break
	fi
done

while true; do
	if [ "`grep no /tmp/SH-OTA.info`" ]; then
		rm -rf /tmp/
		break
	fi

	if [ "`grep yes /tmp/SH-OTA.info`" ]; then
		if [ -f /tmp/$base_name ]; then
			clear
			echo "Installing..."
			cp -f /tmp/$base_name $0
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
