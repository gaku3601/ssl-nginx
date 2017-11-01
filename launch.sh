if [ ! -e /etc/letsencrypt/live ] && [ ! ${STAGE} = "local" ]; then
  echo "証明書が存在しません。発行処理を行います。"
  #nginxの起動
  nginx

  if [ ${STAGE} = "product" ]; then
    #証明書発行処理(product版)
    echo "product版"
    certbot certonly --webroot -w /var/www/letsencrypt -d ${DOMAIN} --agree-tos --non-interactive -m ${EMAIL} --force-renewal
  else
    #証明書発行処理(test版)
    echo "test版"
    certbot certonly --webroot -w /var/www/letsencrypt -d ${DOMAIN} --agree-tos --non-interactive -m ${EMAIL} --test-cert
  fi

  #nginx conf生成処理を記述する
  envsubst '$$DOMAIN' < /init/default.ssl.conf.template > /etc/nginx/conf.d/default.ssl.conf
  nginx -s stop
fi
#nginxの起動
/usr/sbin/nginx -g "daemon off;"
