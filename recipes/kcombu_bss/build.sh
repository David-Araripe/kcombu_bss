#!/usr/bin/env bash

# Build script for conda-forge package.

mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ../src
cmake --build . --config Release
cmake --install .
cd -
