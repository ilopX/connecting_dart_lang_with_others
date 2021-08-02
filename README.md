# Connecting the Dart language with others

## Description
This example repository shows how to combine Dart with other languages such as C ++, Pascal and others.

## Install
* Install Visual Studio 2019 >= ***16.8 Preview 3*** 
* Add environment PATH `c:\Program Files (x86)\Microsoft Visual Studio\.. version ..\MSBuild\Current\Bin`
* CMake >= ***v3.7*** 
* Embracodero RAD Studion >= ***10.3***

| Example `bin` <-> `native_libs`      | Description                                                                                |
| ------------------------------------ | ------------------------------------------------------------------------------------------ |
| [_01_cxx_lib.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/_01_cxx_lib.dart) <-> [cxx_lib](https://github.com/ilopX/connecting_dart_lang_with_others/tree/main/native_libs/cxx_lib)     | Basic example|
| [_02_primitives.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/02_primitives.dart)  <-> [cxx_lib](https://github.com/ilopX/connecting_dart_lang_with_others/tree/main/native_libs/primitives_lib)| Same as [ffi/primitives](https://github.com/dart-lang/samples/tree/master/ffi/primitives)  |
| [_03_struct.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/03_struct.dart) <-> [struct_lib](https://github.com/ilopX/connecting_dart_lang_with_others/tree/main/native_libs/struct_lib)   | Same as [ffi/struct](https://github.com/dart-lang/samples/tree/master/ffi/structs)         |
| [_04_cxx_class_import.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/04_cxx_class_import.dart)  <-> [cxx_class](https://github.com/ilopX/connecting_dart_lang_with_others/tree/main/native_libs/cxx_class)  | C++20 Module and Dart class import        |



