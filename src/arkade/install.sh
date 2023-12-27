#!/bin/sh
set -e

echo "Activating feature 'arkade'"

GET_COMMANDS=${GET_COMMANDS:-undefined}
echo "The provided greeting is: $GET_COMMANDS"


# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final 
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

# install arkade
command -v arkade || {
    command -v curl || {
        cat /etc/os-release
        apt-get update && apt-get install -y curl;
    }
    if command -v sudo
    then
        curl -sLS https://get.arkade.dev | sudo sh;
    else
        curl -sLS https://get.arkade.dev | sh;
    fi
    if [ "$GET_COMMANDS" -ne "undefined" ]
    then
        arkade get ${GET_COMMANDS};
    fi
}