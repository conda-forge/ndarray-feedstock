#!/bin/bash
set -ex

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

cmake -G Ninja ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX ..

cmake --build . -- -v

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  ctest --progress --output-on-failure --verbose
fi

cmake --install .
