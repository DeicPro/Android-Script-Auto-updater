#SH-OTA v1.2 By Deic & DiamondBond

#Variables
var(){
name="Your-Script.sh" #Name of your script file
version="1.0_stable" #Version of your script
source="/system/xbin/" #Source of your script
download="https://www.YourSite.com/Your-Script.sh" #URL to download your script
check="$EXTERNAL_STORAGE/Download/SH-OTA.sh"
script="$EXTERNAL_STORAGE/Download/$name"
rw="mount -o remount rw /system"
ro="mount -o remount ro /system"
}

check_update(){
echo
echo "Checking updates..."
sleep 1
if [ grep $version $source/$name > /dev/null 2>&1 ]; then
clear
rm -f -r $check
echo
echo "You have the latest version."
sleep 1
safe_exit
else
download_update
fi
}

download_update(){
clear
echo
echo "A new version of the script was found..."
echo
echo "Want download it? (Y/N)"
echo
echo -ne "> "
read download_update_opt
case $download_update_opt in
y|Y) download_update_apply;;
n|N) safe_exit;;
*) echo "Write Y or N and press enter..." && download_update;;
esac
}

download_update_apply(){
clear
echo
echo "Downloading..."
sleep 1
am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $download > /dev/null 2>&1
clear
am start -a android.intent.action.MAIN -n jackpal.androidterm/.Term > /dev/null 2>&1
clear
install_update
}

install_update(){
if [ -e $script ]; then
am force-stop com.android.browser
echo
echo "Installing..."
cp -f -r $script $source
sleep 2
chmod 777 $source$name
echo
echo "Done."
sleep 1
safe_exit
else
wait_download
fi
}

wait_download(){
install_update
}

safe_exit(){
rm -f -r $check
rm -f -r $script
$ro
clear
$SHELL -c $source$name
exit
}

#Start
clear
var
$rw
check_update
