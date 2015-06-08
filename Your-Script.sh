#SH-OTA Your-Script By Deic & DiamondBond
#Put this lines in the top of your script

#Variables
a1(){
#From here edit
	#Version of your script = "1.0_stable" <---- IMPORTANT
	na="SH-OTA.sh" #Name of your SH-OTA file
	do="https://www.Your-Site/SH-OTA.sh" #Link of your SH-OTA file
#From here don't edit
	ch="$EXTERNAL_STORAGE/Download/$name"
	br="com.android.browser"
	am=`am start -a android.intent.action`
}

#Download SH-OTA file
a2(){
	$am.VIEW -n $br/.BrowserActivity $download >/dev/null 2>&1
	$am.MAIN -n jackpal.androidterm/.Term >/dev/null 2>&1
	a3
}

#Wait download
a3(){
	a4
}

#Run SH-OTA file
a4(){
	if [ -e $ch ]; then
		am force-stop $br
		$SHELL -c $ch
	else
		a3
	fi
}

#Script start
clear
a1
a2
