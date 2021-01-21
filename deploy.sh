#!/bin/bash
set -e

echo "Starting identidock system"

docker run -d --restart=always --name redis redis
docker run -d --restart=always --name dnmonster amouat/dnmonster:1.0
docker run -d --restart=always --link dnmonster:dnmonster --link redis:redis -e ENV=PROD --name identidock lebowski1/identidock:newest
docker run -d --restart=always --name proxy --link identidock:identidock -p 80:80 -e NGINX_HOST=104.131.163.246 -e NGINX_PROXY=http://identidock:9090 \
lebowski1/proxy:1.0

echo "Started"