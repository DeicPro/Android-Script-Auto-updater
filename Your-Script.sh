#Put this lines in the top of your script
#SH-OTA By Deic & DiamondBond

#Variables
a1(){
#From here edit
	#Version of your script = "1.0_stable" <---- IMPORTANT
	na="SH-OTA.sh" #Name of your SH-OTA file
	do="https://www.Your-Site/SH-OTA.sh" #Link of your SH-OTA file
#From here don't edit
	ch="$EXTERNAL_STORAGE/Download/$name"
	br="com.android.browser"
}

#Download SH-OTA file
a2(){
	am start android.intent.action.VIEW $br $download >/dev/null 2>&1
	am start jackpal.androidterm >/dev/null 2>&1
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
