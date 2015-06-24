#How to

#1• Download SH-OTA.sh

https://github.com/DeicPro/SH-OTA/releases/download/v1.1/your.script

#2• Download ota.sh

https://github.com/DeicPro/SH-OTA/releases/download/v1.1/check.update

#3• Edit your script

3.1• Add the content of SH-OTA.sh in the top of your script

3.2• Put the link of your future modified ota.sh file, example:

	download="https://www.your_site.com/ota.sh"

#4• Edit ota.sh file

4.1• Put the name of your script, example:

	name="your_script.sh"

4.2• Put the latest version of your script, example:

	version="1.0_stable"

4.3• Put the location of your script, example:

	source="/system/xbin/"

4.4• Put the link of the latest version of your script, example:

	download="https://your_Site.com/your_script.sh"

#5• Upload your script & ota.sh files

5.1• Upload to the same site like you put in the file as:
	
	download="https://your_site.com/your_script.sh"

	download="https://your_site.com/ota.sh"
