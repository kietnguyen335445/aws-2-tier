#!/bin/bash

URL='https://www.tooplate.com/zip-templates/2077_modern_town.zip'
ART_NAME='2077_modern_town'
TEMPDIR="/tmp/webfiles"


PACKAGE="apache2 wget unzip"
SVC="apache2"


echo "Running Setup on Ubuntu"

echo "########################################"
echo "Installing packages."
echo "########################################"
sudo apt update
sudo apt install $PACKAGE -y > /dev/null
echo


echo "########################################"
echo "Start & Enable HTTPD Service"
echo "########################################"
sudo systemctl start $SVC
sudo systemctl enable $SVC
echo


echo "########################################"
echo "Starting Artifact Deployment"
echo "########################################"
mkdir -p $TEMPDIR
cd $TEMPDIR
echo

wget -O ${ART_NAME}.zip $URL
if [ $? -ne 0 ]; then
    echo "Failed to download template"
    exit 1
fi
unzip ${ART_NAME}.zip > /dev/null
sudo cp -r $ART_NAME/* /var/www/html/
echo


echo "########################################"
echo "Restarting HTTPD service"
echo "########################################"
sudo systemctl restart $SVC
echo


echo "########################################"
echo "Removing Temporary Files"
echo "########################################"
rm -rf $TEMPDIR
echo "cleanup done"
