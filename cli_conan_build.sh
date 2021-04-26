BUILD_NAME=cli-conan-build
BUILD_NUMBER=2

rm -rf build
mkdir build
pushd build

# 1. remove conan cache
# rm -rf ~/.conan/data

# 2. resolve
conan install .. --build missing
# conan install .. -r demo-conan-virtual --build missing

# 3. build
cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
cmake --build .

# 4. upload & publish build info
jfrog rt bad $BUILD_NAME $BUILD_NUMBER "conanbuildinfo.txt"
jfrog rt u "bin/md5" generic-local/tmp/ --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER
jfrog rt bp $BUILD_NAME $BUILD_NUMBER


# 5. show graph
conan info .. --graph=file.html
