BUILD_NAME=cli-conan-build
BUILD_NUMBER=1

cd build

# 1. resolve
conan install .. -r demo-conan-virtual --build missing

# 2. build
cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
cmake --build .

# 2. mock build by copy
# cp -r ~/.conan/data/zlib .

# 3. upload
conan upload zlib/1.2.11@conan/stable -r demo-conan-local --all

# 4. publish build info
jfrog rt bad $BUILD_NAME $BUILD_NUMBER "../conanbuildinfo.txt"
jfrog rt bp $BUILD_NAME $BUILD_NUMBER

cd ../