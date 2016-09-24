#!/bin/bash
set -ex

echo "------------ start setup.sh --------------"


dm=`docker ps -f name=data-mysql -aq`
if [ -z "${dm}" ]; then
	docker run --name data-mysql -v /var/lib/mysql busybox
fi

mkdir -p ./files/images
da=`docker ps -f name=data-app -aq`
if [ -z "${da}" ]; then
	docker run --name data-airmeet -v /go/airmeet/files:/files busybox
fi

my=`docker ps -f name=mysql -q`
if [ -z "${my}" ]; then
	docker build -t mysql:0.1 ./mysql

	docker run \
		--name mysql \
		--volumes-from data-mysql \
		-v $PWD/mysql/conf.d:/etc/mysql/conf.d \
		-v $PWD/mysql/init.d:/docker-entrypoint-initdb.d \
		-e MYSQL_ROOT_PASSWORD=$DB_PASS \
		-e MYSQL_DATABASE=airmeet \
		-it \
		-d \
		-p 3306:3306 \
		mysql:0.1 mysqld

	sleep 5 #mysql起動待ち
fi

cr=`docker ps -f name=cron -q`
if [ -z "${cr}" ]; then
	docker build -t cron:0.1 ./cron
	docker run \
		--name cron \
		--link mysql \
		-e DB_PASS=$DB_PASS \
		-d \
		cron:0.1
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

am=`docker ps -f name=app -q`
if [ -n "${am}" ]; then
	docker stop app
	docker rm app
fi
docker build -t app:0.1 ./app

docker run \
	--name app \
	--link mysql \
	--volumes-from data-app \
	-e VIRTUAL_HOST=$VIRTUAL_HOST \
	-e DB_PASS=$DB_PASS \
	-it \
	-d \
	-p 3000:3000 \
	app:0.1


echo "------------ end setup.sh --------------"
