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

a6(){
$rm $check
$rm $script
mount -o remount ro /system
$cl
$SHELL -c $source$name
exit
}

a1(){
$ec
$ec "Checking updates..."
$sl
if [ grep $version $source/$name $null ]; then
$cl
$rm $check
$ec
$ec "You have the latest version."
$sl
a6
else
a2
fi
}

a2(){
$cl
$ec
$ec "A new version of the script was found..."
$ec
$ec "Want download it? (Y/N)"
$ec
$ec -ne "> "
read op
case $op in
y|Y) a3;;
n|N) a6;;
*) $ec "Write Y or N and press enter..." && a2;;
esac
}

a3(){
$cl
$ec
$ec "Downloading..."
$sl
$am.VIEW -n com.android.browser/.BrowserActivity $download $null
$am.MAIN -n jackpal.androidterm/.Term $null
$cl
a4
}

a5(){
a4
}

a4(){
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
a6
else
a5
fi
}

#Start
$cl
var
mount -o remount rw /system
a1
