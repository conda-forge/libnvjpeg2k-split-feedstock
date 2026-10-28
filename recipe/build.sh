#!/bin/bash

# Install to conda style directories
[[ -d lib64 ]] && mv lib64 lib
mkdir -p ${PREFIX}/lib
if [[ -d pkg-config ]]; then
    mkdir -p ${PREFIX}/lib/pkgconfig
    mv pkg-config/* ${PREFIX}/lib/pkgconfig/
    rmdir pkg-config
    sed -E -i "s|cudaroot=.+|cudaroot=$PREFIX|g" $PREFIX/lib/pkgconfig/nvjpeg*.pc
fi

for i in `ls`; do
    [[ $i == "build_env_setup.sh" ]] && continue
    [[ $i == "conda_build.sh" ]] && continue
    [[ $i == "metadata_conda_debug.yaml" ]] && continue
    cp -rv $i ${PREFIX}
done

check-glibc "$PREFIX"/lib*/*.so.* "$PREFIX"/bin/* "$PREFIX"/targets/*/lib*/*.so.* "$PREFIX"/targets/*/bin/*
