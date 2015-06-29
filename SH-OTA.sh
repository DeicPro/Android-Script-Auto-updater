SH-OTA(){ #v2.0_alpha By Deic & hoholee12

	#Edit values
	version="version"
	cloud="https://your_site.com/version.sh"

	#Not edit
	base_name=`basename $0`

	mount -o remount,rw rootfs
	mount -o remount,rw /system
	mount -o remount,rw /data
	mkdir -p /tmp/
	chmod 755 /tmp/
	touch /tmp/SH-OTA.info
	chmod 755 /tmp/SH-OTA.info

	if [ ! -f /system/xbin/curl ]; then
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
				mkdir /data/local/ssl/
				mkdir /data/local/ssl/certs/
				cp -f /tmp/curl /system/xbin/
				cp -f /tmp/openssl /system/xbin/
				cp -f /tmp/openssl.cnf /data/local/ssl/
				cp -f /tmp/ca-bundle.crt /data/local/ssl/certs/
				sleep 2
				chmod -R 755 /system/xbin/
				chmod -R 755 /data/local/ssl/
				rm -f $EXTERNAL_STORAGE/download/curl.zip
				break
			fi
		done

		while true; do
			if [ -f /system/xbin/curl ] && [ -f /system/xbin/openssl ] && [ -f /data/local/ssl/openssl.cnf ] && [ -f /data/local/ssl/certs/ca-bundle.crt ]; then
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
	curl -k -L -o /tmp/version.sh $cloud 2>/dev/null

	while true; do
		if [ -f /tmp/version.sh ]; then
			chmod 755 /tmp/version.sh
cat >> /tmp/version.sh <<EOF
if [ "`grep script_version $0 2>/dev/null`" ]; then
	clear
	echo "You have the latest version."
	sleep 1
	echo "no" > /tmp/SH-OTA.info
	exit
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
		n|N ) echo "no" > /tmp/SH-OTA.info; exit;;
		* ) echo "Write [Y] or [N] and press enter..."; sleep 1;;
	esac
done

clear
echo "Downloading..."
sleep 1
curl -k -L -o /tmp/$base_name script_cloud 2>/dev/null
exit
EOF
			sed -i 's/script_version/$version/' /tmp/version.sh
			sed -i 's/script_install/$install_opt/' /tmp/version.sh
			sed -i 's/script_cloud/$cloud/' /tmp/version.sh
			$SHELL -c /tmp/version.sh
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
