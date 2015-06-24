#SH-OTA v1.2_alpha By Deic & DiamondBond

#Edit values
name="script" #Name of your script file
version="version" #Version of your script
location="location" #Location of your script
cloud="https://your_site.com/script" #Download link of your script

#Don't edit
tmp="/data/local/tmp/$name"
script="$location/$name"

install(){
clear
echo
echo "Downloading..."
sleep 1
curl -k -L -o $tmp $cloud >/dev/null 2>&1
while true; do
if [ -f $tmp ]; then
echo
echo "Installing..."
sleep 1
cp -f $tmp $script
rm -f $script
chmod 755 $script
echo
echo "Done."
sleep 1
clear
$script
exit
fi
done
}

clear
echo "Checking updates..."
sleep 1
if [ "`grep $version $script >/dev/null 2>&1`" ]; then
clear
echo "You have the latest version."
sleep 1
exit
fi
while true; do
clear
echo "A new version of the script was found..."
echo
echo "Want install it? (Y/N)"
echo
echo -n "> "
read install_ask_opt
case $install_ask_opt in
y|Y ) install;;
n|N ) exit;;
* ) echo "Write [Y] or [N] and press enter...";;
esac
done
}
