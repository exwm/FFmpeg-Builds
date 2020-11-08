#!/bin/bash

TF_SRC="https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-gpu-windows-x86_64-1.15.0.zip"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerstage() {
    to_df "ADD $SELF /stage.sh"
    to_df "RUN run_stage"
}

ffbuild_dockerbuild() {
    pushd /usr/local || return -1
    wget "$TF_SRC" -O TF.tar.gz || return -1
    unzip -o TF.tar.gz || return -1
    rm TF.tar.gz
    popd || return -1
}

ffbuild_configure() {
    echo --enable-libtensorflow
}

ffbuild_unconfigure() {
    echo --disable-libtensorflow
}

ffbuild_cflags() {
    echo -I/usr/local/include
}

ffbuild_ldflags() {
    echo -L/usr/local/lib
}
