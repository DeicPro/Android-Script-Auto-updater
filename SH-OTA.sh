#SH-OTA By Deic & DiamondBond

#Variables
var(){
	#From here edit
	na="Your-Script.sh" #Name of your script file
	ve="1.0_stable" #Version of your script
	so="/system/xbin/" #Source of your script
	do="https://www.Your-Site.com/Your-Script.sh" #URL to download your script
	#From here don't edit
	ch="$EXTERNAL_STORAGE/Download/SH-OTA.sh"
	sc="$EXTERNAL_STORAGE/Download/$na"
	br="com.android.browser"
	ec="echo"
	cl="clear"
	rm=`rm -f -r`
	sl=`sleep 1`
	am=`am start -a android.intent.action`
	mo=`mount -o remount`
}

a6(){
	$rm $ch
	$rm $sc
	$mo ro /system
	$cl
	$SHELL -c $so$na
	exit
}

a1(){
	$ec
	$ec "Checking updates..."
	$sl
	if [ grep $ve $so/$na >/dev/null 2>&1 ]; then
		$cl
		$rm $ch
		$ec
		$ec "You have the latest version."
		$sl
		a6
	else
		a2
	fi
}

a2(){
	$cl
	$ec
	$ec "A new version of the script was found..."
	$ec
	$ec "Want download it? (Y/N)"
	$ec
	$ec -ne "> "
	read op
	case $op in
		y|Y) a3;;
		n|N) a6;;
		*) $ec "Write Y or N and press enter..." && a2;;
	esac
}

a3(){
	$cl
	$ec
	$ec "Downloading..."
	$sl
	$am.VIEW -n $br/.BrowserActivity $do >/dev/null 2>&1
	$am.MAIN -n jackpal.androidterm/.Term >/dev/null 2>&1
	$cl
	a4
}

a5(){
	a4
}

a4(){
	if [ -e $sc ]; then
		am force-stop $br
		$ec
		$ec "Installing..."
		cp -f -r $sc $so
		sleep 2
		chmod 777 $so$na
		$ec
		$ec "Done."
		$sl
		a6
	else
		a5
	fi
}

#Start
$cl
var
$mo rw /system
a1
