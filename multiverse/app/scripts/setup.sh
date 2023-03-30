#!/bin/bash 
## Install the Drupal site.
##

# Add log lib
. /opt/scripts/log.sh

# Database connection for drush site-install.
dbUrl="mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}"

function install_drupal () {
  info "Installing Drupal profile: Octane.\n"
  drush @telemundo si --db-url=${dbUrl} --account-pass="admin" octane -y
}

install_drupal
