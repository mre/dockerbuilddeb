#!/bin/bash

containerID=`sudo docker run -d magnetikonline/buildphpfpm`
sudo docker cp $containerID:/root/build/php-5.6.0/php_5.6.0-1_amd64.deb .
sleep 1
sudo docker rm $containerID
