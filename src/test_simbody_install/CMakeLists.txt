cmake_minimum_required(VERSION 3.16)
project(test_simbody)

find_package(Simbody 3.7 REQUIRED)

add_executable(test_simbody main.cpp)
#include_directories(${Simbody_INCLUDE_DIRS})
#target_link_libraries(test_simbody ${Simbody_LIBRARIES})
target_link_libraries(test_simbody SimTKsimbody)
