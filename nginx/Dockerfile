FROM jwilder/nginx-proxy
RUN { \
	echo 'server_tokens off;'; \
	echo 'client_max_body_size 50m;'; \
	} > /etc/nginx/conf.d/my_proxy.conf
