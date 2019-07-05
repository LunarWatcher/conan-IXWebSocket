cmake_minimum_required(VERSION 2.8.12)
project(PackageTest CXX)



include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(tests SimpleTests.cpp)

if (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    # Build with Multiple Processes
    target_compile_options(ixwebsocket PRIVATE /MP)
else
    set($CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
endif()

target_link_libraries(tests ${CONAN_LIBS})

