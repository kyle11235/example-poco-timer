
# conan example

- install conan

        - guide
                
                please go to the official guide
                I installed it on centos in python virtualenv

        - centos
                
                - install python3 by source
                - install conan in virtualenv
                        
                        pip3 install pipenv --index-url=https://pypi.org/simple
                        
                        mkdir tmp & cd tmp
                        pipenv install conan (create Pipfile & Pipfile.lock)
                        
                - activate env (every login)
                
                        cd tmp
                        pipenv shell
                        which conan
                        
                        e.g.
                        /root/.local/share/virtualenvs/tmp-xxxxxx/bin/conan  (if change current dir name, virtualenv will not be found)

                        conan -v
                        
                        e.g.
                        Conan version 1.35.2

        - mac

                mac, builtin python3                
                pip3 install conan --user (installed into /Users/kyle/Library/Python/3.8/bin)
                
                sudo vi /etc/profile
                export PYTHON_HOME=/Users/kyle/Library/Python/3.8/
                export $PATH:$PYTHON_HOME/bin
                source /etc/profile
                conan -v

- install compiler

        - install g++
        
                yum group install "Development Tools"
                which g++
                e.g.
                /usr/bin/g++
        
        - install cmake
       
                cd /opt
        
                wget https://github.com/Kitware/CMake/releases/download/v3.18.5/cmake-3.18.5-Linux-x86_64.sh

                chmod +x cmake-3.18.5-Linux-x86_64.sh
                ./cmake-3.18.5-Linux-x86_64.sh

                Yn
                
                vi /etc/profile
                export PATH=$PATH:/opt/cmake-3.18.5-Linux-x86_64/bin

                vi /etc/profile
                export CXX=/usr/bin/g++

        - install bzip2-devel
        
                yum install -y bzip2-devel.x86_64
                (fix fatal error: bzlib.h: No such file or directory)

- configure conan repo

        - check configured remotes
                
                conan remote list

        - add repo   
        
                conan remote add demo-conan-local http://x.x.x.x:8081/artifactory/api/conan/demo-conan-local
                conan user -p apikey_xxx -r demo-conan-local kyle

                - ERROR: The remote at 'http://x.x.x.x:8081/artifactory/api/conan/demo-conan-virtual' only works with revisions enabled. 
                Set CONAN_REVISIONS_ENABLED=1 or set 'general.revisions_enabled = 1' at the 'conan.conf'. [Remote: demo-conan-virtual]
        
                - fix
                vi ~/.conan/conan.conf
                [general]
                revisions_enabled = 1

- test 

        - install/resolve pkg

                - search local cached pkg

                        conan search

                - search remote

                        conan search poco --remote=conan-center

                - inspect

                        conan inspect poco/1.9.4

                - check default profile

                        cat ~/.conan/profiles/default

                - build

                        ./build.sh
                        ./cli_conan_build.sh

        - new package

                - new pkg
                
                        mkdir mypkg && cd mypkg
                        conan new hello/0.1 -t

                - check conanfile.py

                        it's just like a jenkins pipeline
                        steps of codes to git clone -> build -> package

                - test/install to local cache

                        ./build.sh
                        ./build_3_steps_upload.sh

                - check what is installed

                        cd /root/.conan/data/hello/0.1/demo/testing

                        ./export
                        ├── conanfile.py
                        └── conanmanifest.txt

                        ./pacakge
                        └── e5ac722d270cf7c45ba6c1301f2e878770b1eea3
                        ├── conaninfo.txt
                        ├── conanmanifest.txt
                        ├── include
                        │   └── hello.h
                        └── lib
                                └── libhello.a

                



