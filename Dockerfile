FROM nginx:1.13.6
MAINTAINER gaku3601

RUN apt-get update && \
  apt-get install -y certbot

RUN apt-get install -y cron
RUN echo '00 0 * * 6 root /usr/bin/certbot renew >> /var/log/cron.log 2>&1' >> /etc/cron.d/certbot-cron
RUN chmod 0644 /etc/cron.d/certbot-cron
RUN touch /var/log/cron.log

RUN mkdir -p /var/www/letsencrypt

ADD ./conf.d/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

CMD cron && nginx -g 'daemon off;'
