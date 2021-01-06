#!/bin/bash

export BOOST_DIR=$PREFIX
export EIGEN_DIR=$PREFIX
export FFTW_DIR=$PREFIX
export CMAKE_PREFIX_PATH=$PREFIX


mkdir build
cd build
cmake ${CMAKE_ARGS} -DNDARRAY_PYBIND11=ON -DCMAKE_INSTALL_PREFIX=$PREFIX ..
make
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make test ARGS="-V"
fi

make install
