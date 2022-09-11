#!/bin/bash

export BOOST_DIR=$PREFIX
export EIGEN_DIR=$PREFIX
export FFTW_DIR=$PREFIX
export CMAKE_PREFIX_PATH=$PREFIX

mkdir build
cd build
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
  # enable pybind11 testing only if native building
  CMAKE_ARGS+=" -DNDARRAY_PYBIND11=ON"
else
  CMAKE_ARGS+=" -DNDARRAY_TEST=NO"
fi

cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX ..
make VERBOSE=1

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  make test ARGS="-V"
fi

make install
