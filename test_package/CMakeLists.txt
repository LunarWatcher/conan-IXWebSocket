cmake_minimum_required(VERSION 2.8.12)
project(PackageTest CXX)



include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(tests SimpleTests.cpp)

set($CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")


target_link_libraries(tests ${CONAN_LIBS})

