#!/bin/bash
set -ex

echo "------------ start setup.sh --------------"


mkdir -p $PWD/static #staticファイルの置き場所

# アプリのデータコンテナ 起動していないときだけ起動する
da=`docker ps -f name=data-app -aq`
if [ -z "${da}" ]; then
	docker run --name data-app -v $PWD/static:/static busybox
fi

# Nginxのコンテナ 起動していないときだけ起動する
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

# 画像処理部分のコンテナ deployの度に再起動
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


# railsアプリのコンテナ deployの度に再起動
sp=`docker ps -f name=selp -q`
if [ -n "${sp}" ]; then
	docker stop selp
	docker rm selp
fi
docker build -t selp:0.1 ./app

docker run \
	--name selp \
	--link image_engine \
	--volumes-from data-app \
	-e RAILS_ENV=$ENV \
	-e RACK_ENV=$ENV \
	-d \
	-p 3000:3000 \
	selp:0.1



echo "------------ end setup.sh --------------"
