#Put this lines in the top of your script
#SH-OTA By Deic & DiamondBond
variables(){
#From here edit
	#Version of your script = "1.0_stable" <---- IMPORTANT
	name="SH-OTA.sh" #Name of your SH-OTA file
	cloud="https://www.Your-Site/SH-OTA.sh" #Link of your SH-OTA file
#From here don't edit
	file="$EXTERNAL_STORAGE/Download/$name"
}

download(){
	am start android.intent.action.VIEW com.android.browser $cloud 1>/dev/null
	am start jackpal.androidterm 1>/dev/null
	wait_download
}

wait_download(){
	run_sh_ota
}

run_sh_ota(){
	if [ -f $file ]; then
		am force-stop com.android.browser
		$SHELL -c $file
	else
		wait_download
	fi
}

#Script start
clear
variables
download
