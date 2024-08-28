FROM nginx:alpine3.18

COPY nginx.conf /etc/nginx/conf.d
COPY proxy_params /etc/nginx
RUN rm /etc/nginx/conf.d/default.conf