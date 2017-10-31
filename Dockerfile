FROM nginx:1.13.6
MAINTAINER gaku3601
RUN apt-get update
RUN apt-get install -y supervisor

RUN apt-get install -y certbot
RUN apt-get install -y cron
RUN echo '00 0 * * 6 root /usr/bin/certbot renew >> /var/log/cron.log 2>&1' >> /etc/cron.d/certbot-cron
RUN chmod 0644 /etc/cron.d/certbot-cron
RUN touch /var/log/cron.log

RUN mkdir -p /var/www/letsencrypt
ADD ./conf.d/default.conf /etc/nginx/conf.d/default.conf
ADD ./conf.d/default.ssl.conf /init/default.ssl.conf
ADD ./launch.sh /init/launch.sh

RUN touch /etc/supervisord.conf
RUN echo '[supervisord]'  >> /etc/supervisord.conf
RUN echo 'nodaemon=true'  >> /etc/supervisord.conf
RUN echo '[program:launch]' >> /etc/supervisord.conf
RUN echo 'command=bash /init/launch.sh'   >> /etc/supervisord.conf
RUN echo 'stdout_logfile=/var/log/nginx.log' >> /etc/supervisord.conf

EXPOSE 80 443

CMD cron && /usr/bin/supervisord -c /etc/supervisord.conf
