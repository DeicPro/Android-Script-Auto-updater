#SH-OTA v1.2_alpha By Deic & hoholee12

#Edit values
name="your_script.sh"
version="version"
location="/system/xbin"
cloud="https://your_site.com/ota.sh"

#Not edit
# Busybox Applet Generator 2.4
# You can type in any commands you would want it to check.
# It will start by checking from cmd1, and its limit is up to cmd224.
cmd1=dirname
cmd2=basename
cmd3=ls
cmd4=grep
cmd5=head
cmd6=awk
cmd7=cat
cmd8=pgrep
cmd9=ps
cmd10=cp
cmd11=cut
cmd= # It notifies the generator how many cmds are available for check. Leave it as blank.

silent_mode= # enabling this will hide errors.
# This feature might not be compatible with some other multi-call binaries.
# if similar applets are found and Busybox do not have them, it will still continue but leave out some error messages regarding compatibility issues.
bb_check= # BB availability.
bb_apg_2(){
	if [[ "$1" == -f ]]; then
		shift
		used_fopt=1
	elif [[ "$1" == -g ]]; then
		shift
		used_gopt=1
	fi
	if [[ "$used_fopt" == 1 ]]||[[ "$used_gopt" == 1 ]]; then
		silent_mode=1
		if [[ "$cmd" ]]; then
			if [[ "$cmd" -lt 0 ]]; then
				cmd=0
			fi
		else
			cmd=224
		fi
		for i in $(seq -s ' $cmd' 0 $cmd | sed 's/^0//'); do
			v=$(eval echo $i)
			x=$(echo $i | sed 's/^\$//')
			export $x=$v #export everything.
			if [[ "$v" ]]; then
				unset $x
			else
				break #reduce cycle
			fi
		done
		for j in $(seq 1 $cmd); do
			if [[ ! "$1" ]]; then
				break
			fi
			export cmd$j=$1
			shift
		done
		export cmd=$j #this will reduce more cycles.
	fi
	bb_check=0
	local n i busyboxloc busyboxenv fail
	if [[ ! "$(busybox)" ]]; then #allow non-Busybox users to continue.
		bb_check=1
		if [[ "$silent_mode" != 1 ]]; then
			echo "Busybox does not exist! Busybox is required for best compatibility!"
		fi
		if [[ "$cmd" ]]; then
			if [[ "$cmd" -lt 0 ]]; then
				cmd=0
			fi
		else
			cmd=224
		fi
		for i in $(seq -s ' $cmd' 0 $cmd | sed 's/^0//'); do
			v=$(eval echo $i)
			x=$(echo $i | sed 's/^\$//')
			export $x=$v #export everything.
			if [[ "$v" ]]; then
				if [[ ! "$(which $v)" ]]; then
					if [[ "$silent_mode" != 1 ]]; then
						echo "required applet: '$v' does not exist!"
					fi
					fail=1 #fail later
				fi
			else
				break #reduce cycle
			fi
		done
	else
		busyboxloc=$(dirname $(which busybox))
		n=0
		for i in $(echo $PATH | sed 's/:/ /g'); do
			n=$(($n+1))
			export slot$n=$i
			if [[ "$i" == "$busyboxloc" ]]; then
				busyboxenv=slot$n
			fi
		done
		if [[ "$busyboxenv" != slot1 ]]; then
			export PATH=$(echo -n $busyboxloc
			for i in $(seq -s ' $slot' 0 $n | sed 's/^0//'); do
				v=$(eval echo $i)
				if [[ "$v" != "$busyboxloc" ]]; then
					echo -n ":$v"
				fi
			done)
		fi
		if [[ "$cmd" ]]; then
			if [[ "$cmd" -lt 0 ]]; then
				cmd=0
			fi
		else
			cmd=224
		fi
		for i in $(seq -s ' $cmd' 0 $cmd | sed 's/^0//'); do
			v=$(eval echo $i)
			x=$(echo $i | sed 's/^\$//')
			export $x=$v #export everything.
			if [[ "$v" ]]; then
				if [[ ! "$(busybox | grep "\<$v\>")" ]]; then
					if [[ "$silent_mode" != 1 ]]; then
						echo -n "required applet: '$v' not embedded in Busybox!"
					fi
					if [[ ! "$(which $v)" ]]; then
						if [[ "$silent_mode" != 1 ]]; then
							echo "...and also does not exist!"
						fi
						fail=1 #fail later
					else
						if [[ "$silent_mode" != 1 ]]; then
							echo
						fi
					fi
				fi
				if [[ ! -e "$busyboxloc"/"$v" ]]; then
					alias $i="busybox $i"
				fi
			else
				break #reduce cycle
			fi
		done
	fi 2>/dev/null
	if [[ "$used_gopt" == 1 ]]&&[[ "$bb_check" == 1 ]]; then
		fail=1 #used_gopt is NOT recommended, unless needed for specific use.
	fi
	if [[ "$fail" == 1 ]]; then #the fail manager!
		if [[ "$used_fopt" == 1 ]]||[[ "$used_gopt" == 1 ]]; then
			unset used_fopt
			unset used_gopt
			return 1
		fi
		echo -e "process terminated. \e[1;31m\"error code 1\"\e[0m"
		return 1
	fi
}
bb_apg_2

mount_rw="mount -o remount,rw"
info=/tmp/SH-OTA.info
ext="$EXTERNAL_STORAGE/download/curl.zip"
ssl="/data/local/ssl"
certs="$ssl/certs/"
xbin="/system/xbin"
ota="/tmp/ota.sh"
tmp="/tmp/$name"
script="$location/$name"

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
	sleep 1
	am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity https://github.com/DeicPro/Download/releases/download/curl/curl.zip >/dev/null 2>&1
	curl="1"
fi

if [ "$curl" == 1 ]; then
	while true; do
		if [ -f $ext ]; then
			kill -9 $(pgrep com.android.browser)
			clear
			echo "Installing..."
			sleep 1
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
			chmod 755 $xbin/curl
			chmod 755 $xbin/openssl
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
curl -klos $ota $cloud

while true; do
	if [ -f $ota ]; then
		chmod 755 $ota
		$ota
		break
	fi
done

while true; do
	if [ "`grep no $info`" ]; then
		break
	fi
	if [ "`grep yes $info`" ]; then
		if [ -f $tmp ]; then
			clear
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
	fi
done
