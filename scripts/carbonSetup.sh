#!/bin/bash
#************************************************************************
#Name: carbonSetup.sh
#Author: Randall D. Rowland Jr.
#Date: July 22, 2017
#Description:   This script sets up directories on the Lenovo X1 Carbon for
#               use with Conky. It will then add the command into startup
#               programs so Conky will start on boot.
#Input:     bg-ubuntu.png
#           ipcheck.sh
#Output:    ~/.local/share/images
#           ~/.local/share/images/bg-ubuntu.png
#           ~/.local/share/scripts
#           ~/.local/share/scripts/ipcheck.sh
#           ~/.local/share/scripts/conkyRestart.sh
#           ~/.config/autostart/conky.desktop           
#Usage:     Make this script executable and place it in a folder with the
#           associated .conkyrc file and background image. Then run this
#           script 
#           chmod +x carbonSetup.sh
#           ./carbonSetup.sh
#Known bugs/missing features:
#
#This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0
#International Public License. To view a tellery of this license, visit
#https://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative
#Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
#
#Modifications:
#Date                Comment
#----    ------------------------------------------------
#26JUL17    Added conkyRestart.sh to scripts that will be installed
#26JUL17    Modified startup desktop file to run conkyRestart.sh
#************************************************************************/

#Check to see if Conky is installed
command -v conky >/dev/null 2>&1 || 
    {   
        echo >&2 "This script requires Conky but it's not installed. Aborting. Run 'sudo apt-get install conky-all'"; 
        sleep 30; 
        exit 1; 
    }

#Folder Variables
CUR_DIR="$(pwd)"
MAIN_RES_DIR="/home/$USER/.local/share"
SCRIPTS="$MAIN_RES_DIR/scripts"
IMAGES="$MAIN_RES_DIR/images"
AUTOSTART_DIR="/home/$USER/.config/autostart"
CONKY_AUTOSTART="$AUTOSTART_DIR/conky.desktop"

#Check to see if Conky is running. If it is, kill it.
CONKY_PID="$(pidof conky)"
if [ "$CONKY_PID" > "0" ]; then
    kill $CONKY_PID
    echo "The running process of Conky has been killed."
fi

#Create folders for scripts and background image
echo "Creating required folders."
mkdir -p $IMAGES
mkdir -p $SCRIPTS

#Create startup desktop file
echo "Adding Conky to startup."
touch $CONKY_AUTOSTART
echo "[Desktop Entry]" >> $CONKY_AUTOSTART
echo "Type=Application" >> $CONKY_AUTOSTART
echo "Exec=/home/$USER/.local/share/scripts/conkyRestart.sh" >> $CONKY_AUTOSTART
echo "Hidden=false" >> $CONKY_AUTOSTART
echo "NoDisplay=false" >> $CONKY_AUTOSTART
echo "X-GNOME-Autostart-enabled=true" >> $CONKY_AUTOSTART
echo "Name[en_US]=Conky" >> $CONKY_AUTOSTART
echo "Name=Conky" >> $CONKY_AUTOSTART
echo "Comment[en_US]=Light-weight system monitor" >> $CONKY_AUTOSTART
echo "Comment=Light-weight system monitor" >> $CONKY_AUTOSTART

#Add scripts and images to folders
echo "Adding Conky scripts."
mv ipcheck.sh $SCRIPTS/
chmod +x $SCRIPTS/ipcheck.sh
echo "Adding background image."
mv ../resources/bg-ubuntu.png $IMAGES/

#Move Conky configuration file
mv ../src/conkyrc ~/.conkyrc

#Restart Conky
echo "Starting Conky."
conky 2> /dev/null &
echo "Conky Started."