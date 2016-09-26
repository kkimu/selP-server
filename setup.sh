#!/bin/bash
set -ex

echo "------------ start setup.sh --------------"


mkdir -p $PWD/static
da=`docker ps -f name=data-app -aq`
if [ -z "${da}" ]; then
	docker run --name data-app -v $PWD/static:/static busybox
fi

my=`docker ps -f name=postgres -q`
if [ -z "${my}" ]; then
	docker build -t postgres:0.1 ./postgres

	docker run \
		--name postgres \
		-e POSTGRES_PASSWORD=$DB_PASS \
		-d \
		-p 5432:5432 \
		postgres:0.1

fi


ng=`docker ps -f name=nginx -q`
if [ -z "${ng}" ]; then
	docker build -t nginx:0.1 ./nginx
	docker run \
		--name nginx \
		-v /var/run/docker.sock:/tmp/docker.sock:ro \
		-p 80:80 \
		-d \
		nginx:0.1
fi


ie=`docker ps -f name=image_engine -q`
if [ -n "${ie}" ]; then
	docker stop image_engine
	docker rm image_engine
fi
docker build -t image_engine:0.1 ./image_engine

docker run \
	--name image_engine \
	--volumes-from data-app \
	-d \
	-p 5000:5000 \
	image_engine:0.1


sp=`docker ps -f name=selp -q`
if [ -n "${sp}" ]; then
	docker stop selp
	docker rm selp
fi
docker build -t selp:0.1 ./app

docker run \
	--name selp \
	--link postgres \
	--link image_engine \
	--volumes-from data-app \
	-e VIRTUAL_HOST=$VIRTUAL_HOST \
	-e DB_PASS=$DB_PASS \
	-e RAILS_ENV=$ENV \
	-e RACK_ENV=$ENV \
	-d \
	-p 3000:3000 \
	selp:0.1




echo "------------ end setup.sh --------------"
