#SH-OTA v1.2_alpha By Deic & DiamondBond

#Variables

#From here edit
name="script" #Name of your script file
version="version" #Version of your script
location="location" #Location of your script
script_cloud="https://yoursite/script" #Download link of your script

#From here don't edit
script="/data/local/tmp/$name"

check_update(){
#clear
echo
echo "Checking updates..."
sleep 1
if [ "`grep $version $location/$name`" ]; then
#clear
echo
echo "You have the latest version."
sleep 1
exit
else
ask_download
fi
}

ask_download(){
#clear
echo
echo "A new version of the script was found..."
echo
echo "Want download it? (Y/N)"
echo
echo -n "> "
read ask_download_opt
case $ask_download_opt in
y|Y ) download_update;;
n|N ) custom_exit;;
* ) echo "Write [Y] or [N] and press enter..."; ask_download;;
esac
}

download_update(){
#clear
echo
echo "Downloading..."
sleep 1
curl -k -L -o $script $script_cloud #>/dev/null 2>&1
install_update
}

install_update(){
#clear
if [ -f $script ]; then
echo
echo "Installing..."
sleep 1
cp -rf $script $location
rm -rf $script
chmod 755 $location/$name
echo
echo "Done."
sleep 1
custom_exit
else
install_update
fi
}

custom_exit(){
#clear
rm -rf /data/local/tmp/ota.sh
$SHELL -c $location/$name
exit
}

#Start
check_update
