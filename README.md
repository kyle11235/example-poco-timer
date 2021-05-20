
# conan example

- prepare env

        - install conan
        please go to the official guide
        I installed it on centos in python virtualenv
        
        Conan version 1.35.2
        
        - install g++
        yum group install "Development Tools"
        
        - install cmake
        export CXX=/usr/bin/g++

        - install bzip2-devel
        yum install -y bzip2-devel.x86_64

        - configure conan repo
        conan remote add demo-conan-local http://xxx:8081/artifactory/api/conan/demo-conan-local
        conan user -p apikey_xxx -r demo-conan-local myusername
        adjust setting according to the prompt error message

- test

        ./build.sh

