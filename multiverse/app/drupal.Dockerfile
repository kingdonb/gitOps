FROM drupal:9.5.7-php8.1-fpm-alpine

# Add required libs
RUN apk add git openssh bash mysql-client
# Pass in ssh key 
RUN mkdir -p -m 0700 ~/.ssh && ln -s /run/secrets/ssh_key ~/.ssh/id_rsa && ssh-keyscan github.com >> ~/.ssh/known_hosts
# clear working folder
RUN rm -rf /opt/drupal && mkdir /opt/drupal
# set working folder
WORKDIR /opt/drupal
# import project
RUN --mount=type=ssh git clone --depth=1 'git@github.com:nbcnews/nbcu-multiverse-drupal.git' .
# overwrite composer | Wont be necessary once we modify in the project
COPY ./composer.json composer.json
# bring over the setup file
COPY ./scripts /opt/scripts
RUN chmod -R 777 /opt/scripts

# Install process
RUN set -eux; \
    # Set temp composer home
    export COMPOSER_HOME="$(mktemp -d)"; \
    rm composer.lock; \
    # composer install
    composer install; \
    # change ownership
    chown -R www-data:www-data docroot; \
    # link to web servers docroot
    ln -sf /opt/drupal/docroot /var/www/docroot; \
    # clean up
    rm -rf "$COMPOSER_HOME" 

ENTRYPOINT ["/opt/scripts/entrypoint.sh"]
CMD ["/bin/bash"]