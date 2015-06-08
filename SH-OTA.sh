#SH-OTA By Deic & DiamondBond

#Variables
a1(){
#From here edit
	na="Your-Script.sh" #Name of your script file
	ve="1.0_stable" #Version of your script
	so="/system/xbin/" #Location of your script
	do="https://www.Your-Site.com/Your-Script.sh" #Link of your script
	ns="SH-OTA.sh" #Name of your SH-OTA file
#From here don't edit
	ch="$EXTERNAL_STORAGE/Download/$ns"
	sc="$EXTERNAL_STORAGE/Download/$na"
	br="com.android.browser"
	ec="echo"
	cl="clear"
	rm=`rm -f -r`
	sl=`sleep 1`
	am=`am start -a android.intent.action`
	mo=`mount -o remount`
}

#Safe exit
a2(){
	$rm $ch
	$rm $sc
	$mo ro /system
	$cl
	$SHELL -c $so$na
	exit
}

#Check update
a3(){
	$ec
	$ec "Checking updates..."
	$sl
	if [ grep $ve $so/$na >/dev/null 2>&1 ]; then
		$cl
		$rm $ch
		$ec
		$ec "You have the latest version."
		$sl
		a2
	else
		a4
	fi
}

#Ask download
a4(){
	$cl
	$ec
	$ec "A new version of the script was found..."
	$ec
	$ec "Want download it? (Y/N)"
	$ec
	$ec -ne "> "
	read op
	case $op in
		y|Y) a5;;
		n|N) a2;;
		*) $ec "Write Y or N and press enter..." && a4;;
	esac
}

#Download update
a5(){
	$cl
	$ec
	$ec "Downloading..."
	$sl
	$am.VIEW -n $br/.BrowserActivity $do >/dev/null 2>&1
	$am.MAIN -n jackpal.androidterm/.Term >/dev/null 2>&1
	$cl
	a6
}

#Wait download
a6(){
	a7
}

#Install update
a7(){
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
		a2
	else
		a6
	fi
}

#Script start
$cl
a1
$mo rw /system
a3
