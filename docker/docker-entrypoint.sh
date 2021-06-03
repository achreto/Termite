#! /bin/bash

#
# the docker entry point -- setup environment and execute command / drop into shell
#

echo "================================================"
echo "Build docker container"
echo "================================================"

# this is the docker entrypoint
cd $HOME/Termite

if [ "$1" == "" ]; then
    echo "starting shell..."
    exec "/bin/bash"
    exit 0
else
    echo "executing '$@'"
    exec "$@"
fi
