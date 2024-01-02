#!/bin/sh
set -e

echo "Activating feature 'weave'"

GET_COMMANDS=${GET_COMMANDS:-undefined}
echo "The provided greeting is: $GET_COMMANDS"

echo proxy variables:
env|grep -i proxy


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

command -v curl || {
    cat /etc/os-release
    apt-get update && apt-get install -y curl;
}

# install weave
curl --silent --location "https://github.com/weaveworks/weave-gitops/releases/latest/download/gitops-$(uname)-$(uname -m).tar.gz" | tar xz -C /tmp
[ ! -d "$HOME/.local/bin" ] && { mkdir -p $HOME/.local/bin; }
mv /tmp/gitops $HOME/.local/bin
[ ! -d "$HOME/.config" ] && { mkdir -p $HOME/.config; }
$HOME/.local/bin/gitops set config analytics false