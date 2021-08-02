cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(cxx_lib VERSION 1.0.0 LANGUAGES C)

add_library(cxx_lib SHARED lib_cxx.c lib_cxx.def)
