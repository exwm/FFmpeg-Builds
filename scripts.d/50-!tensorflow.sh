#!/bin/bash

TF_SRC="https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-gpu-linux-x86_64-1.15.0.tar.gz"

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
    tar xzf TF.tar.gz || return -1
    rm TF.tar.gz
    ldconfig
    ldconfig -p | grep tensorflow
    popd || return -1
}

ffbuild_configure() {
    echo --enable-libtensorflow
}

ffbuild_unconfigure() {
    echo --disable-libtensorflow
}
