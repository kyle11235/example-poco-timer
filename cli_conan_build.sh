BUILD_NAME=cli-conan-build
BUILD_NUMBER=1

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

# 4. upload a lib
# cp -r ~/.conan/data/zlib .
# conan upload zlib/1.2.11@conan/stable -r demo-conan-local --all

# 5. publish build info
jfrog rt bad $BUILD_NAME $BUILD_NUMBER "../conanbuildinfo.txt"
jfrog rt bp $BUILD_NAME $BUILD_NUMBER
