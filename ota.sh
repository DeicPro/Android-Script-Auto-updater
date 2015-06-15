#SH-OTA v1.2_W.I.P. By Deic & DiamondBond

#Variables

#From here edit
name="Your-Script.sh" #Name of your script file
ver="1.0_stable" #Version of your script
loc="/system/xbin/" #Location of your script
cloud="https://www.Your-Site.com/Your-Script.sh" #Download link of your script

#From here don't edit
tmp="/data/local/tmp/"
ota="$tmp/$ota_name"
script="$tmp/$name"
mo=`mount -o remount`
ec="echo "
cl="clear"
sl=`sleep 1`

check_update(){
$ec
$ec "Checking updates..."
$sl
if [ "`grep $ver $loc/$name 1>/dev/null`" ]
then
$cl
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
cp -rf $script $loc
sleep 2
chmod 755 $loc/$name
$ec
$ec "Done."
$sl
safe_exit
fi
}

safe_exit(){
$mo,ro /system 2>/dev/null
$mo,ro /data 2>/dev/null
$cl
sh $loc/$name
exit
}

#Start
$cl
$mo,rw /system
$mo,rw /data
check_update
