#SH-OTA v1.2 By Deic & DiamondBond

#Variables
var(){
name="Your-Script.sh" #Name of your script file
version="1.0_stable" #Version of your script
source="/system/xbin/" #Source of your script
download="https://www.Your-Site.com/Your-Script.sh" #URL to download your script
check="$EXTERNAL_STORAGE/Download/SH-OTA.sh"
script="$EXTERNAL_STORAGE/Download/$name"
null=`>/dev/null 2>&1`
rm=`rm -f -r`
sl=`sleep 1`
ec="echo"
cl="clear"
am=`am start -a android.intent.action`
}

che(){
$ec
$ec "Checking updates..."
$sl
if [ grep $version $source/$name $null ]; then
$cl
$rm $check
$ec
$ec "You have the latest version."
$sl
saf
else
dow
fi
}

dow(){
$cl
$ec
$ec "A new version of the script was found..."
$ec
$ec "Want download it? (Y/N)"
$ec
$ec -ne "> "
read dowo
case $dowo in
y|Y) dowa;;
n|N) saf;;
*) $ec "Write Y or N and press enter..." && dow;;
esac
}

dowa(){
$cl
$ec
$ec "Downloading..."
$sl
$am.VIEW -n com.android.browser/.BrowserActivity $download $null
$am.MAIN -n jackpal.androidterm/.Term $null
$cl
ins
}

ins(){
if [ -e $script ]; then
am force-stop com.android.browser
$ec
$ec "Installing..."
cp -f -r $script $source
sleep 2
chmod 777 $source$name
$ec
$ec "Done."
$sl
saf
else
wai
fi
}

wai(){
ins
}

saf(){
$rm $check
$rm $script
mount -o remount ro /system
$cl
$SHELL -c $source$name
exit
}

#Start
$cl
var
mount -o remount rw /system
che
