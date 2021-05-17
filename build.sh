#!/bin/bash

set -e
set -x

rm -rf build
mkdir build
pushd build

conan install .. --build=missing
# conan install .. --build=missing -r=demo-conan-virtual -pr ./my_profile

cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .

bin/md5
