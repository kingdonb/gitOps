FROM nginx:1.23.3-alpine as nginx

# Change the nginx user to user 1000 for sharing volumes with cli container.
# RUN apk --no-cache add shadow && usermod -u 1000 nginx

# Add composer installed tools to path.
ENV PATH=$PATH:/var/www/vendor/bin

# Customize nginx.conf.
COPY nginx.conf /etc/nginx/templates/default.conf.template

WORKDIR /var/www