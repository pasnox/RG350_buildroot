#!/bin/bash -e

if [ "${BASH_SOURCE}" != "" ]; then
    SCRIPT_FILE_PATH=$(readlink -f "${BASH_SOURCE}")
else
    SCRIPT_FILE_PATH=$(readlink -f "${0}")
fi
SCRIPT_PATH=$(dirname "${SCRIPT_FILE_PATH}")

export TARGET_DEVICE=gcw0
export OPENDINGUX_ROOT_PWD=$(realpath ${SCRIPT_PATH}/..)
export TOOLCHAIN_VERSION=$(git --git-dir ${OPENDINGUX_ROOT_PWD}/.git rev-parse --short HEAD)
export TOOLCHAIN_VERSION=master
export TOOLCHAIN_OUTPUT_PWD=${OPENDINGUX_ROOT_PWD}/_output/${TARGET_DEVICE}-toolchain-${TOOLCHAIN_VERSION}
export TOOLCHAIN_DESTDIR_PWD=${TOOLCHAIN_OUTPUT_PWD}/prefix
export TOOLCHAIN_PREFIX_PWD=/opt/${TARGET_DEVICE}-toolchain-${TOOLCHAIN_VERSION}

export BR2_JLEVEL=0

function _make {
    make \
        O=${TOOLCHAIN_OUTPUT_PWD} \
        "$@"
}

_make rg350_defconfig BR2_EXTERNAL=board/opendingux
# _make toolchain # toolchain only
_make sdk # full sdk
