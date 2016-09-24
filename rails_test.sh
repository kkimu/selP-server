docker run \
	--name selp \
	-e VIRTUAL_HOST=$VIRTUAL_HOST \
	-e DB_PASS=$DB_PASS \
	-it \
	-d \
	-p 3000:3000 \
	selp:0.1
