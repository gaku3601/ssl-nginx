#nginxの起動
nginx

#証明書発行処理(test版)
certbot certonly --webroot -w /var/www/letsencrypt -d ${DOMAIN} --agree-tos --non-interactive -m ${EMAIL} --test-cert

#nginx conf生成処理を記述する
cp /init/default.ssl.conf /etc/nginx/conf.d/default.ssl.conf

#nginxの再起動
nginx -s stop
/usr/sbin/nginx -g "daemon off;"
