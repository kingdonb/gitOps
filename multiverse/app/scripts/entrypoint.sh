#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/scripts/log.sh

########################
# Print the welcome page for a Docker image
# Globals:
#   APP_NAME
# Arguments:
#   None
# Returns:
#   None
#########################
print_welcome_page() {
    local github_url="https://github.com/telemundo/gitOps"

    log ""
    log " ${BOLD}Welcome to the Telemundo ${APP_NAME:-Multiverse} container${RESET}"
    log " Submit issues and feature requests at ${BOLD}${github_url}/issues${RESET}"
    log ""
}
print_welcome_page

. /opt/scripts/setup.sh

echo ""
exec "$@"
