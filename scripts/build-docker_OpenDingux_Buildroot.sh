#!/bin/bash -e

if [ "${BASH_SOURCE}" != "" ]; then
    SCRIPT_FILE_PATH=$(readlink -f "${BASH_SOURCE}")
else
    export SCRIPT_FILE_PATH=$(readlink -f "${0}")
fi
export SCRIPT_PATH=$(dirname "${SCRIPT_FILE_PATH}")

docker build -t opendingux/buildroot -f ${SCRIPT_PATH}/OpenDingux_Buildroot.Dockerfile .
