#!/bin/bash

set -e
set -x

rm -rf build
mkdir build
pushd build

conan install .. --build=missing

# cp ../CMakeLists1.txt ../CMakeLists.txt
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$PWD
cmake --build .

# not bin/md5
./md5
