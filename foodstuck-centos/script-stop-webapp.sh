#!/bin/bash
# Name: Nguyen Ngoc Tai
# Email: nguyenngoctaibp@gmail.com
# github: https://github.com/tainguyenbp

# Variable Global
NC='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NAME_IMAGE_BUILD="tainguyenbp/foodtrucks-webapplication:1.0"
NAME_BRIDGE_NETWORK="foodtrucks-net"
NAME_IMAGE_ELASTICSEARCH="docker.elastic.co/elasticsearch/elasticsearch:6.3.2"
NAME_IMAGE_RUN_WEBAPP="foodtrucks-webapplication"


function STOP_NETWORK(){

	CHECK_NETWORK=`docker network ls | grep "$NAME_BRIDGE_NETWORK" | wc -l`
	if [ $CHECK_NETWORK -le 0 ];
		then
			echo "done network"
	elif [ $CHECK_NETWORK -ge 1 ];
		then
			docker network rm "$NAME_BRIDGE_NETWORK"
	fi
}

function STOP_ELASTICSEARCH(){
	CHECK_ELASTICSEARCH=`docker container ps -a | grep "$NAME_IMAGE_ELASTICSEARCH" | wc -l`
	if [ $CHECK_ELASTICSEARCH -le 0 ];
		then
			echo "done elasticsearch"
	elif [ $CHECK_ELASTICSEARCH -ge 1 ];
		then 
			docker container rm -f es
	fi
}

function STOP_WEBAPPLICATION(){
	CHECK_WEBAPPLICATION=`docker container ps -a | grep "$NAME_IMAGE_RUN_WEBAPP" | wc -l`
	if [ $CHECK_WEBAPPLICATION -le 0 ];
                then
			echo "done webapplication"
	elif [ $CHECK_WEBAPPLICATION -ge 1 ];
                then
			 docker container rm -f "$NAME_IMAGE_RUN_WEBAPP"
	fi
}

STOP_ELASTICSEARCH
STOP_WEBAPPLICATION
STOP_NETWORK

