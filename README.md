#SH-OTA

A stuff to auto-update your script

#How to

#1• Download Android Terminal Emulator:

https://play.google.com/store/apps/details?id=jackpal.androidterm


#2• Download SH-OTA.sh

https://github.com/DeicPro/SH-OTA/releases/download/v1.1/check.update


#3• Edit SH-OTA file

3.1• Put the name of your script, example:

name="myscript.sh"

3.2• Put the latest version of your script, example:

version="1.0_stable"

3.3• Put the location of your script, example:

source="/system/xbin/"

3.4• Put the link of the latest version of your script, example:

download="https://www.Your-Site.com/Your-Script.sh"


#4• Edit your own script

4.1• Add the content of Your-Script.sh in the top of your script

https://github.com/DeicPro/SH-OTA/releases/download/v1.1/your.script


4.2• Put the link of your modified SH-OTA file, example:

download="https://www.Your-Site.com/SH-OTA.sh"


#5• Upload SH-OTA file

5.1• Upload to the same site like you put in the file as:

download="https://www.Your-Site.com/SH-OTA.sh"

download="https://www.Your-Site.com/Your-Script.sh"
