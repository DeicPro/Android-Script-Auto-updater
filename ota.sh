#SH-OTA By Deic & DiamondBond

#Variables

#From here edit
name="Your-Script.sh" #Name of your script file
ver="1.0_stable" #Version of your script
loc="/system/xbin/" #Location of your script
cloud="https://www.Your-Site.com/Your-Script.sh" #Download link of your script
ota_name="SH-OTA.sh" #Name of your SH-OTA file

#From here don't edit
tmp="/data/local/tmp/"
ota="$tmp/$ota_name"
script="$tmp/$name"
ec="echo "
cl="clear"
rm=`rm -f`
sl=`sleep 1`
mo=`mount -o remount`

check_update(){
$ec
$ec "Checking updates..."
$sl
if [ "`grep $ver $loc/$name 1>/dev/null`" ]
then
$cl
$rm $ota
$ec
$ec "You have the latest version."
$sl
safe_exit
else
ask_download
fi
}

ask_download(){
$cl
$ec
$ec "A new version of the script was found..."
$ec
$ec "Want download it? (Y/N)"
$e
$e-ne"> "
read opt
case $opt in
y|Y ) download_update;;
n|N ) safe_exit;;
* ) $ec "Write [Y] or [N] and press enter..."; ask_download;;
esac
}

download_update(){
$cl
$ec
$ec "Downloading..."
$sl
curl -k -L -o  $script $cloud 1>/dev/null
$cl
install_update
}

install_update(){
if [ -e $script ]
then
$ec
$ec "Installing..."
cp -f $script $loc
sleep 2
chmod 755 $loc/$name
$ec
$ec "Done."
$sl
safe_exit
fi
}

safe_exit(){
$rm $ota
$rm $script
$mo,ro /system
$mo,ro /data
$cl
$SHELL -c $loc/$name
exit
}

#Start
$cl
$mo,rw /system
$mo,rw /data
check_update
