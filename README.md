# letsencrypt
test
## test用での証明書発行
certbot certonly --webroot -w /var/www/letsencrypt -d gaku.gakusmemo.com --agree-tos --non-interactive -m pro.gaku@gmail.com --test-cert
## 本番用での証明
certbot certonly --webroot -w /var/www/letsencrypt -d gaku.gakusmemo.com --agree-tos --non-interactive -m pro.gaku@gmail.com --force-renewal

