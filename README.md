# Android-Script-Auto-updater

[B][U][SIZE="5"]How to[/SIZE][/U][/B]

[URL="https://play.google.com/store/apps/details?id=jackpal.androidterm"]Android Terminal Emulator (recommended)[/URL]

1. Download SH-OTA (down)

2. Edit SH-OTA file
2.1. Put the name of your own script, example:
[CODE]name="myscript.sh"[/CODE]
2.2. Put the latest version of your own script, example:
[CODE]version="1.0_stable"[/CODE]
2.3. Put the location of your own script, example:
[CODE]source="/system/xbin/"[/CODE]
2.4. Put the link of the latest version of your own script, example:
[CODE]download="https://www.mysite.com/myscript.sh"[/CODE]

3. Edit your own script
3.1. Add the content of Your-Script.sh in the top of your own script

3.2. Put the link of your modified SH-OTA file, example:
[CODE]name="http://www.mysite.com/check.update[/CODE]

4. Upload SH-OTA file
4.1. Upload to the same site as you put in the file as [download="...]
