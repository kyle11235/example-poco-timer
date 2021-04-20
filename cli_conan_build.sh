BUILD_NAME=cli-conan-build
BUILD_NUMBER=1

# cmake . -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
# cmake --build .

cp -r ~/.conan/data/zlib .
conan upload zlib/1.2.11@conan/stable -r demo-conan-local --all

# jfrog rt bad $BUILD_NAME $BUILD_NUMBER "libs/"
# jfrog rt u "build/" generic-local/kyle/ --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER
# jfrog rt bp $BUILD_NAME $BUILD_NUMBER