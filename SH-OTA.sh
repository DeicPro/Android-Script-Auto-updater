#SH-OTA By Deic & DiamondBond
#Variables
#From here edit
n="Your-Script.sh" #Name of your script file
v="1.0_stable" #Version of your script
s="/system/xbin/" #Location of your script
d="https://www.Your-Site.com/Your-Script.sh" #Link of your script
h="SH-OTA.sh" #Name of your SH-OTA file
#From here don't edit
k=" $EXTERNAL_STORAGE/Download/$h"
i=" $EXTERNAL_STORAGE/Download/$n "
b=" com.android.browser "
e="echo "
c="clear"
r=`rm -f`
s=`sleep 1`
m=`mount -o remount`
a=`am start`
#Safe exit
2(){
$r$k
$r$i
$m,ro /system
$c
$SHELL -c $s/$n
exit
}
#Check update
3(){
$e
$e"Checking updates..."
$s
if["`grep $v $s/$n 1>/dev/null`"]
then
$c
$r$k
$e
$e"You have the latest version."
$s
2
else
4
fi
}
#Ask download
4(){
$c
$e
$e"A new version of the script was found..."
$e
$e"Want download it? (Y/N)"
$e
$e-ne"> "
read op
case $op in
y|Y)5;;
n|N)2;;
*)$e"Write Y/N and press enter..."&&4;;
esac
}
#Download update
5(){
$c
$e
$e"Downloading..."
$s
$a android.intent.action.VIEW$b$d 1>/dev/null
$a jackpal.androidterm 1>/dev/null
$c
6
}
#Wait download
6(){
	7
}
#Install update
7(){
if[-e$i]
then
am force-stop$b
$e
$e"Installing..."
cp -f$i$s
sleep 2
chmod 755 $s/$n
$e
$e"Done."
$s
2
else
6
fi
}
#Script start
$c
$m,rw /system
3
