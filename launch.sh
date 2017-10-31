if [ ! -e /etc/letsencrypt/live ]; then
  echo "証明書が存在しません。発行処理を行います。"
  #nginxの起動
  nginx

  #証明書発行処理(test版)
  certbot certonly --webroot -w /var/www/letsencrypt -d ${DOMAIN} --agree-tos --non-interactive -m ${EMAIL} --test-cert

  #nginx conf生成処理を記述する
  cp /init/default.ssl.conf /etc/nginx/conf.d/default.ssl.conf
  nginx -s stop
fi
#nginxの起動
/usr/sbin/nginx -g "daemon off;"
