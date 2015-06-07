#SH-OTA.sh v1.2 By Deic & DiamondBond
#Put this lines in the top of your script

#Variables
#Version of your script = 1.0_stable
var(){
#Edit this:
	name="SH-OTA.sh"
	download="https://www.Your-Site/SH-OTA.sh"
#Don't edit:
	check="$EXTERNAL_STORAGE/Download/$name"
	browser="am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity"
	term="am start -a android.intent.action.MAIN -n jackpal.androidterm/.Term"
	null=">/dev/null 2>&1"
}

download(){
	$browser $download $null
	$term $null
	check_update
}

check_update(){
	if [ -e $check ]; then
		am force-stop com.android.browser
		$SHELL -c $check
	else
		wait_download
	fi
}

wait_download(){
	check_update
}

#Start
clear
var
download
