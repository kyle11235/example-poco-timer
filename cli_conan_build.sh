BUILD_NAME=cli-conan-build
BUILD_NUMBER=7

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

$ 4. create dependency graph
conan info .. --graph=dependency_graph.html

# 5. upload & publish build info
jfrog rt u "bin/md5" generic-local/tmp/ --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER
jfrog rt u "conaninfo.txt" generic-local/tmp/ --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER
jfrog rt u "dependency_graph.html" generic-local/tmp/ --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER

jfrog rt bad $BUILD_NAME $BUILD_NUMBER "conanbuildinfo.txt"
jfrog rt bp $BUILD_NAME $BUILD_NUMBER
