#!/bin/bash -e

if [ "${BASH_SOURCE}" != "" ]; then
    SCRIPT_FILE_PATH=$(readlink -f "${BASH_SOURCE}")
else
    SCRIPT_FILE_PATH=$(readlink -f "${0}")
fi
SCRIPT_PATH=$(dirname "${SCRIPT_FILE_PATH}")

# gcw0, rg350m, pandora
# TARGET_DEVICE=

if [ -z "${TARGET_DEVICE}" ]; then
    echo "Undefined TARGET_DEVICE"
    exit 1
fi

${SCRIPT_FILE_PATH}/build-docker_OpenDingux_Buildroot.sh

DOCKER_CONTAINER_ID=`docker run -itd --privileged=true opendingux/buildroot bash`

# docker cp .git ${DOCKER_CONTAINER_ID}:/work/src/.git/
# docker cp genrecovery.sh ${DOCKER_CONTAINER_ID}:/work/
# docker exec -it ${DOCKER_CONTAINER_ID} /bin/sh /work/genrecovery.sh
# docker cp ${DOCKER_CONTAINER_ID}:/work/tmp/recovery.img .
# docker cp ${DOCKER_CONTAINER_ID}:/work/src/update/update-image.swu .
# docker container stop ${DOCKER_CONTAINER_ID}
# docker container rm ${DOCKER_CONTAINER_ID}

export TOOLCHAIN_VERSION=master
export TOOLCHAIN_VERSION=$(git --git-dir ${SCRIPT_PATH}/.git rev-parse --short HEAD)
export TOOLCHAIN_OUTPUT_PWD=${SCRIPT_PATH}/_output/${TARGET_DEVICE}-toolchain-${TOOLCHAIN_VERSION}
export TOOLCHAIN_DESTDIR_PWD=${TOOLCHAIN_OUTPUT_PWD}/prefix
export TOOLCHAIN_PREFIX_PWD=/opt/${TARGET_DEVICE}-toolchain-${TOOLCHAIN_VERSION}

export BR2_JLEVEL=0

function _make {
    make \
        O=${TOOLCHAIN_OUTPUT_PWD} \
        VERBOSE=1 \
        "$@"
}

_make rg350_defconfig BR2_EXTERNAL=board/opendingux
_make menuconfig
_make toolchain
