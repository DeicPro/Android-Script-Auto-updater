#SH-OTA v1.2_alpha By Deic & DiamondBond

#Variables

#From here edit
name="Your-Script.sh" #Name of your script file
ver="1.0_stable" #Version of your script
loc="/system/xbin/" #Location of your script
cloud="https://www.Your-Site.com/Your-Script.sh" #Download link of your script

#From here don't edit
script="/data/local/tmp/$name"

check_update(){
echo
echo "Checking updates..."
sleep 1

if [ "`grep $ver $loc/$name 1>/dev/null`" ]
then
clear
echo
echo "You have the latest version."
sleep 1

custom_exit
else
ask_download
fi
}

ask_download(){
clear
echo
echo "A new version of the script was found..."
echo
echo "Want download it? (Y/N)"
echo
echo -ne "> "

read opt
case $opt in
y|Y ) download_update;;
n|N ) custom_exit;;
* ) echo "Write [Y] or [N] and press enter..."; ask_download;;
esac
}

download_update(){
clear
echo
echo "Downloading..."
sleep 1

curl -k -L -o  $script $cloud 1>/dev/null

install_update
}

install_update(){
clear
if [ -e $script ]
then
echo
echo "Installing..."
sleep 1

cp -rf $script $loc

chmod 755 $loc/$name

echo
echo "Done."
sleep 1

custom_exit
else
install_update
fi
}

custom_exit(){
clear
$SHELL -c $loc/$name
exit
}

#Start
clear
check_update
