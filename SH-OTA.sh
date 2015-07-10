SH-OTA(){ # v2.1_alpha By Deic, DiamondBond & hoholee12

	# Configuration
	version="version"
	cloud="https://your_site.com/update.txt"

	# Optional
	notes_cloud="https://your_site.com/notes.txt"

	# 0/1 = Disabled/Enabled
	show_version="1"
	show_notes="0"

	# Don't touch from here
	dir="/data/SH-OTA/"
	tools_cloud="https://github.com/DeicPro/Download/releases/download/Tools/SH-OTA_Tools.zip"
	download_dir="$EXTERNAL_STORAGE/download/"
	busybox="$dir/busybox"
	script_name=`basename $0`

	mount -o remount,rw rootfs
	mount -o remount,rw /system
	mount -o remount,rw /data
	mkdir -p $dir
	chmod 755 $dir

	if [ ! -f $dir/busybox ] && [ ! -f $dir/curl ] && [ ! -f $dir/openssl ] && [ ! -f $dir/ssl/openssl.cnf] && [ ! -f $dir/ssl/certs/ca-bundle.crt ]; then
		clear
		echo "Downloading SH-OTA Tools..."
		am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $tools_cloud >/dev/null 2>&1

		while true; do
			if [ -f $download_dir/SH-OTA_Tools.zip ]; then
				kill -9 $(pgrep com.android.browser)
				sleep 5
				break
			fi
		done

		clear
		echo "Installing SH-OTA Tools..."
		cp -f $download_dir/SH-OTA_Tools.zip $dir/Tools.zip
		sleep 2
		chmod 755 $dir/Tools.zip
		unzip -o -q $dir/Tools.zip

		while true; do
			if [ -f $dir/busybox ] && [ -f $dir/curl ] && [ -f $dir/openssl ] && [ -f $dir/ssl/openssl.cnf] && [ -f $dir/ssl/certs/ca-bundle.crt ]; then
				cp -f -R $dir/ssl/ /data/local/
				sleep 2
				chmod -R 755 /data/SH-OTA/
				chmod -R 755 /data/local/ssl/
				rm -f $download_dir/SH-OTA_Tools.zip
				rm -f $dir/Tools.zip
				rm -f -R $dir/ssl/
				clear
				echo "Installed."
				sleep 1.5
			fi
		do
	fi

	clear
	echo "Checking updates..."
	curl -k -L -o $dir/update.txt $cloud 2>/dev/null

	if [ "$show_notes" == 1 ]; then
		curl -k -L -o $dir/notes.txt $notes_cloud 2>/dev/null
	fi

	while true; do
		if [ -f $dir/update.txt ]; then
			if [ "`grep $version $dir/update.txt 2>/dev/null`" ]; then
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

				if [ "$show_notes" == 1 ] && [ -f $dir/notes.txt ]; then
					cat tmp/notes.txt
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
		curl -k -L -o $dir/$script_name $(cat $dir/update.txt | tr '\n' ',' | cut -d',' -f2) 2>/dev/null
	fi

	while true; do
		if [ "$install" == 0 ]; then
			clear
			break
		fi

		if [ -f $dir/$script_name ]; then
			clear
			echo "Installing..."
			cp -f $dir/$script_name $0
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
}
SH-OTA
