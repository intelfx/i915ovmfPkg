#!/bin/bash -ex

ARGS=( "$@" ); set --

source "${BASH_SOURCE%/*}/config"

export PACKAGES_PATH="$WORKSPACE/edk2:$WORKSPACE/edk2-platforms"

cd "$WORKSPACE"
. edk2/edksetup.sh
if ! [[ -f edk2/BaseTools/Source/C/bin ]]; then
    make -j$(nproc) -C edk2/BaseTools
fi
if (( "${#ARGS[@]}" )); then
    build "${ARGS[@]}"
else
    build -v -a X64 -t GCC5 -b DEBUG -p i915ovmfPkg/i915ovmf.dsc
fi
