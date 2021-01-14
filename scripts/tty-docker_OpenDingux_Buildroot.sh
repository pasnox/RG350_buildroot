#!/bin/bash

if [ "${BASH_SOURCE}" != "" ]; then
    SCRIPT_FILE_PATH=$(readlink -f "${BASH_SOURCE}")
else
    SCRIPT_FILE_PATH=$(readlink -f "${0}")
fi
SCRIPT_PATH=$(dirname "${SCRIPT_FILE_PATH}")

${SCRIPT_PATH}/build-docker_OpenDingux_Buildroot.sh

docker \
    run \
    --interactive \
    --tty \
    --rm \
    --user=dingux \
    --name opendingux-buildroot-live \
    --mount type=bind,src=${SCRIPT_PATH}/..,dst=/work/OpenDingux_Buildroot \
    opendingux/buildroot \
    /bin/bash --rcfile /etc/skel/.bashrc
