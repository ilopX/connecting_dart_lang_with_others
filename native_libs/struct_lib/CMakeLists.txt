cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(struct_lib VERSION 1.0.0 LANGUAGES C)
add_library(struct_lib SHARED struct.c struct.def)

add_executable(test test.c)
target_link_libraries(test struct_lib)
