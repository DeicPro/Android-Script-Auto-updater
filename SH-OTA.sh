SH-OTA(){ # v2.1_unstable By Deic, DiamondBond & hoholee12

	# Configuration
	version="version"
	cloud="https://your_site.com/update.txt"

	# Optional
	notes_cloud="https://your_site.com/notes.txt"

	# 0/1 = Disabled/Enabled
	show_version="1"
	show_notes="0"


	# Don't touch from here
	busybox_cloud="https://github.com/DeicPro/Download/releases/download/busybox/busybox"
	curl_cloud="https://github.com/DeicPro/Download/releases/download/curl/curl.zip"
	base_name=`basename $0`

	mount -o remount,rw rootfs
	mount -o remount,rw /system
	mount -o remount,rw /data
	mkdir -p /tmp/
	chmod 755 /tmp/

	if [ ! -f /data/SH-OTA_Busybox]; then # to be replaced
		clear
		echo "Downloading Busybox binaries..."
		am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $busybox_cloud >/dev/null 2>&1

		while true; do
			if [ -f $EXTERNAL_STORAGE/download/busybox ]; then
				kill -9 $(pgrep com.android.browser)
				sleep 10
				break
			fi
		done

		clear
		echo "Installing Busybox..."
		cp $EXTERNAL_STORAGE/download/busybox /tmp/
		cd /tmp/
		chmod 755 busybox

		for i in $(busybox find /system/xbin/ -type l); do
			if [ busybox readlink $i | busybox grep -q busybox ]; then
				busybox rm $i
			fi
		done

		cp busybox /system/xbin/
		cd /
		chmod 755 /system/xbin/busybox
		busybox --install -s /system/xbin/
		touch /data/SH-OTA_busybox
		clear
		echo "Installed."
		sleep 1.5
	fi

	if [ ! -f /system/xbin/curl ]; then
		clear
		echo "Curl binaries not found."
		sleep 1.5
		clear
		echo "Downloading curl binaries..."
		am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $curl_cloud >/dev/null 2>&1

		while true; do
			if [ -f $EXTERNAL_STORAGE/download/curl.zip ]; then
				kill -9 $(pgrep com.android.browser)
				sleep 10
				break
			fi
		done

		clear
		echo "Installing..."
		unzip -oq $EXTERNAL_STORAGE/download/curl.zip -d /tmp/

		while true; do
			if [ -f /tmp/curl ] && [ -f /tmp/openssl ] && [ -f /tmp/openssl.cnf ] && [ -f /tmp/ca-bundle.crt ]; then
				mkdir /data/local/ssl/
				mkdir /data/local/ssl/certs/
				cd /tmp/
				cp -f curl /system/xbin/
				cp -f openssl /system/xbin/
				cp -f openssl.cnf /data/local/ssl/
				cp -f ca-bundle.crt /data/local/ssl/certs/
				sleep 2
				cd /
				chmod -R 755 /system/xbin/
				chmod -R 755 /data/local/ssl/
				rm -f $EXTERNAL_STORAGE/download/curl.zip

				clear
				echo "Installed."
				sleep 1.5
				break
			fi
		done
	fi

	clear
	echo "Checking updates..."
	curl -k -L -o /tmp/update.txt $cloud 2>/dev/null

	if [ "$show_notes" == 1 ]; then
		curl -k -L -o /tmp/notes.txt $notes_cloud 2>/dev/null
	fi

	while true; do
		if [ -f /tmp/update.txt ]; then
			if [ "`grep $version /tmp/update.txt 2>/dev/null`" ]; then
				clear
				echo "You have the latest version."
				sleep 1.5
				install="0"
				break
			else
				if [ "$show_version" == 1 ]; then
					version_opt=": $version"
				else
					version_opt="..."
				fi

				clear
				echo "A new version of the script was found$version_opt"
				echo

								if [ "$show_notes" == 1 ] && [ -f /tmp/notes.txt ]; then
					cat /tmp/notes.txt
					echo
				fi

				echo "Want install it? (Y/N)"
				echo
				echo -n "> "
				read i
				case $i in
					y|Y )
						install="1"
						break
					;;
					n|N )
						install="0"
						break
					;;
					* )
						echo "Write [Y] or [N] and press enter..."
						sleep 1.5
					;;
				esac
			fi
		fi
	done

	if [ "$install"  == 1 ]; then
		clear
		echo "Downloading..."
		curl -k -L -o /tmp/$base_name $(cat /tmp/update.txt | tr '\n' ',' | cut -d',' -f2) 2>/dev/null
	fi

	while true; do
		if [ "$install" == 0 ]; then
			clear
			break
		fi

		if [ -f /tmp/$base_name ]; then
			clear
			echo "Installing..."
			cp -f /tmp/$base_name $0
			sleep 2
			chmod 755 $0
			clear
			echo "Installed."
			sleep 1.5
			$SHELL -c $0
			clear
			exit
		fi
	done

	rm -f /tmp/*
}
SH-OTA
