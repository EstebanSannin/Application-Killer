#!/bin/bash
#   
#
# Application Killer 1.0 
#
#
# AUTHOR:  Stefano Viola <alias> Esteban Sannin
# VERSION: 1.0
# LICENSE: GPLv3
# DEPENDENCIES: gdialog
# CHANGES:
#   v1.0: 20090612
#     * first public release
# # 
#
# CREDITS
# Thanks to Ivan Morgillo for his "killfox script"

function clean {
    if [ -e /tmp/pid ]; then
	rm /tmp/pid
    fi
}

# Makes cleand
clean


temp=`tempfile`
gdialog --title "Application Killer 1.0" \
--inputbox "Insert name application to kill:                                                                 |" \
150 500 "firefox"  2>$temp

app=`cat $temp`
null=

#Structure control
if [$app = $null]; then
    gdialog --title "Application Killer 1.0" \
	--infobox "Annulled Application !" 100 100;
    exit 1
else
# Finds PID and kills it!
    ps aux | grep $app | grep -v defunct | grep -v grep > /tmp/pid

    GREPEXIT=`echo $?`
    if [ $GREPEXIT = 0 ]; then
	PID=`awk '{print $2}' /tmp/pid`
	kill -9 $PID
	gdialog --infobox "PID is $PID ---> Fuck you $app ! " 0 0;
	clean
    else
	gdialog --infobox "No $app running instance or not found!"
	exit 1
    fi
fi