# build
# 1. export conanfile.py to local cache
conan export . demo/testing 

# 2. install pkg, force build from source
conan install hello/0.1@demo/testing --build=hello

# 3. test it
conan test test_package hello/0.1@demo/testing

# upload
conan upload hello/0.1@demo/testing --all -r=demo-conan-local

# test resolve
conan remove "hello*"
conan install hello/0.1@demo/testing --build=naven -r=demo-conan-virtual
conan test test_package hello/0.1@demo/testing

