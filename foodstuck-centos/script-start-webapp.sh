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

function BUILD_IMAGE_DOCKERFILE(){
# Build the flask app base on Dockerfile
	echo -e "${GREEN}Build the flask app base on Dockerfile${NC}"
	docker build -t "$NAME_IMAGE_BUILD" "$CURRENT_DIR"
}

function START_NETWORK(){
# Create bridge network foodtrucks-net use for new containers
	echo -e "${GREEN}Create bridge network foodtrucks-net use for new containers${NC}"
	CHECK_NETWORK=`docker network ls | grep "$NAME_BRIDGE_NETWORK" | wc -l`
	if [ $CHECK_NETWORK -le 0 ];
		then
			echo -e "${GREEN}Bridge network foodtrucks-net is starting ....${NC}"
			docker network create -d bridge "$NAME_BRIDGE_NETWORK"
	elif [ $CHECK_NETWORK -ge 1 ];
		then
			echo -e "${RED}Bridge network foodtrucks-net is exists${NC}"
	fi
}

function START_ELASTICSEARCH(){
# Start the ES container
# Run a elasticsearch base on docker.elastic.co/elasticsearch/elasticsearch:6.3.2
# Run of them --detach (or -d ), name them with --name es on 9200:9200 and 9300:9300
# When elasticsearch use the --env option (or -e ) to pass in discovery.type=single-node
	echo -e "${GREEN}Start the ES container${NC}"
	echo -e "${GREEN}Run a elasticsearch base on docker.elastic.co/elasticsearch/elasticsearch:6.3.2${NC}"
	echo -e "${GREEN}Run of them --detach (or -d ), name them with --name es on 9200:9200 and 9300:9300${NC}"
	echo -e "${GREEN}When elasticsearch use the --env option (or -e ) to pass in discovery.type=single-node${NC}"
	CHECK_ELASTICSEARCH=`docker container ps -a | grep "$NAME_IMAGE_ELASTICSEARCH" | grep "Up" | wc -l`
	if [ $CHECK_ELASTICSEARCH -le 0 ];
		then
			echo -e "${GREEN}docker.elastic.co/elasticsearch/elasticsearch:6.3.2 is starting .......${NC}"
			docker container run -d --name es --net "$NAME_BRIDGE_NETWORK" -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" "$NAME_IMAGE_ELASTICSEARCH"
	elif [ $CHECK_ELASTICSEARCH -ge 1 ];
		then 
			echo -e "${RED}docker.elastic.co/elasticsearch/elasticsearch:6.3.2 is running with status Up${NC}"
	fi
}

function START_WEBAPPLICATION(){

# Run the falsk app base on this image above
# Run of them --detach (or -d ), name them with --name es on 5000:5000
	echo -e "${GREEN}Run the falsk app base on this image above${NC}"
	echo -e "${GREEN}Run of them --detach (or -d ), name them with --name es on 5000:5000${NC}"
	CHECK_WEBAPPLICATION=`docker container ps -a | grep "$NAME_IMAGE_RUN_WEBAPP" | grep "Up" | wc -l`
	if [ $CHECK_WEBAPPLICATION -le 0 ];
                then
			echo -e "${GREEN} falsk app foodtrucks-webapplication is starting .....${NC}"
			docker container run -d --net "$NAME_BRIDGE_NETWORK" -p 5000:5000 --name "$NAME_IMAGE_RUN_WEBAPP" "$NAME_IMAGE_BUILD"
	elif [ $CHECK_WEBAPPLICATION -ge 1 ];
                then
			 echo -e "${RED}foodtrucks-webapplication is running with status Up${NC}"
	fi
}

BUILD_IMAGE_DOCKERFILE
START_NETWORK
START_ELASTICSEARCH
START_WEBAPPLICATION

# Show process running when run images
echo -e "${GREEN}Show process running when run images${NC}"
docker container ps

# Show log container realtime
echo -e "${GREEN}Show log container running realtime${NC}"
docker container logs "$NAME_IMAGE_RUN_WEBAPP" -f

