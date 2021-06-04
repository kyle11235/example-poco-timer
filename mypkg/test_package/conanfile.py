import os

from conans import ConanFile, CMake, tools


class HelloTestConan(ConanFile):

    settings = "os", "compiler", "build_type", "arch"

    # An important difference with respect to standard package recipes is that 
    # you don’t have to declare a requires attribute to depend on the tested hello/0.1@demo/testing package 
    # as the requires will automatically be injected by Conan during the run. 
    # However, if you choose to declare it explicitly, it will work, 
    # but you will have to remember to bump the version, and possibly also the user and channel if you decide to change them.
    
    # 1. required pkg/dep / pkg to be tested,  = conanfile.txt's [requires]
    # requires = "hello/0.1@demo/testing"

    # 2. generator's class name, = conanfile.txt's [generators]
    generators = "cmake"

    # copy hello/0.1@demo/testing's shared lib into bin, example.cpp -> #include "hello.h"
    def imports(self):
        self.copy("*.dll", dst="bin", src="bin")
        self.copy("*.dylib*", dst="bin", src="lib")
        self.copy('*.so*', dst='bin', src='lib')

    def build(self):
        cmake = CMake(self)
        # Current dir is "test_package/build/<build_id>" and CMakeLists.txt is
        # in "test_package"
        cmake.configure()
        cmake.build()

    # 3. conan create . demo/testing -> conan test test_package hello/0.1@demo/testing -> ... -> build -> test
    def test(self):
        if not tools.cross_building(self):
            os.chdir("bin")
            self.run(".%sexample" % os.sep)
