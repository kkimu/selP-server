#!/bin/bash
set -ex

echo "------------ start setup.sh --------------"


mkdir -p $PWD/static/jidoris #画像ファイルの置き場所
rm -rf $PWD/static/products
mkdir -p $PWD/static/products
mkdir -p $PWD/static/outputs

# アプリのデータコンテナ 起動していない場合のみ起動
da=`docker ps -f name=data-app -aq`
if [ -z "${da}" ]; then
	docker rm data-app
	docker run --name data-app -v $PWD/static:/static busybox
fi

# postgresのコンテナ
db=`docker ps -f name=db -q`
if [ -z "${db}" ]; then
	docker build -t postgres:0.1 ./db

	docker run \
		--name db \
		-e POSTGRES_PASSWORD=dbpass \
		-d \
		-p 5432:5432 \
		postgres:0.1
fi

# Nginxのコンテナ 起動していない場合のみ起動
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
cv=`docker ps -f name=cv -aq`
if [ -n "${cv}" ]; then
	docker stop cv
	docker rm cv
fi
docker build -t cv:0.1 ./cv

docker run \
	--name cv \
	--volumes-from data-app \
	-e ENV=$ENV \
	-d \
	-p 5000:5000 \
	cv:0.1


# web-apiのコンテナ deployの度に再起動
wa=`docker ps -f name=web-api -aq`
if [ -n "${wa}" ]; then
	docker stop web-api
	docker rm web-api
fi
docker build -t web-api:0.1 ./web-api

docker run \
	--name web-api \
	--link cv \
	--link db \
	--volumes-from data-app \
	-e VIRTUAL_HOST=$VIRTUAL_HOST \
	-e RAILS_ENV=$ENV \
	-e RACK_ENV=$ENV \
	-e SECRET_KEY_BASE=$SECRET_KEY_BASE \
	-d \
	-p 3000:3000 \
	web-api:0.1



echo "------------ end setup.sh --------------"
