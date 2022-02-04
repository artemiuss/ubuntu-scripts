#!/bin/sh

echo "Disk usage before cleanup:"
sudo df -h

DISK_USAGE_BEFORE_CLEANUP=$(df -h)

#Cleaning up tmp
sudo rm -rf /tmp/*

#Delete all .gz and rotated file
sudo find /var/log -type f -regex ".*\.gz$" | xargs sudo rm -Rf
sudo find /var/log -type f -regex ".*\.[0-9]$" | xargs sudo rm -Rf

#Clean clears out the local repository of retrieved package files. 
#It removes  everything but the lock file from /var/cache/apt/archives/ and /var/cache/apt/archives/partial/.
sudo apt clean -y

#Getting rid of no longer required packages
sudo apt autoremove --purge -y

# Remove the Trash
sudo rm -rf /home/*/.local/share/Trash/*/**
sudo rm -rf /root/.local/share/Trash/*/**

#Cleaning is completed
echo "Cleaning is completed"

echo "Disk usage after cleanup:"
sudo df -h