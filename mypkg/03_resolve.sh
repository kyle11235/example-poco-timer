

# clear local cache
conan remove "hello*"

# no build happens
conan install hello/0.1@demo/testing --build=never -r=demo-conan-virtual
conan test test_package hello/0.1@demo/testing

