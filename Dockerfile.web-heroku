FROM nginx:latest

RUN rm -f /etc/nginx/conf.d/*

COPY ./infra/web/nginx.conf /etc/nginx/conf.d/app.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf