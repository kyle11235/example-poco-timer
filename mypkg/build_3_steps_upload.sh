# 1. export conanfile.py to local cache
conan export . demo/testing 

# 2. install pkg, force build from source
# like building missing pkgs, my pkg build happens in
# ~/.conan/data/pkg/.../build/conanfile.py
# ~/.conan/data/pkg/.../build/hello/hello.cpp
# ~/.conan/data/pkg/.../build/hello/CMakeLists.txt
# ~/.conan/data/pkg/.../build (cmake --build .)

# conanfile.py - https://docs.conan.io/en/latest/reference/conanfile.html#conanfile-reference
# cmake build helper - https://docs.conan.io/en/latest/reference/build_helpers/cmake.html
conan install hello/0.1@demo/testing --build=hello

# 3. test it
conan test test_package hello/0.1@demo/testing

# upload
conan upload hello/0.1@demo/testing --all -r=demo-conan-local

# test resolve
conan remove "hello*"
conan install hello/0.1@demo/testing --build=never -r=demo-conan-virtual
conan test test_package hello/0.1@demo/testing

