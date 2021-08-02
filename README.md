# Connecting the Dart language with others

## Description
This example repository shows how to combine Dart with other languages such as C ++, Pascal and others.

## SetUp
* Install Visual Studio 2019 >= ***16.8 Preview 3*** 
* Add environment PATH `c:\Program Files (x86)\Microsoft Visual Studio\.. VERSION ..\MSBuild\Current\Bin`
* CMake >= ***v3.7*** 
* Install Embracodero RAD Studio Community (x64) >= ***10.3***
* Add environment PATH `C:\Program Files (x86)\Embarcadero\Studio\.. VERSION ..\bin\`

| Example `bin` | `native_libs` | Description |
| --- | --- | --- |
| [_01_cxx_lib.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/_01_cxx_lib.dart) | [cxx_lib](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/native_libs/cxx_lib/lib_cxx.c) | Basic example |
| [_02_primitives.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/_02_primitives.dart)  | [primitives_lib](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/native_libs/primitives_lib/math.c)| Same as [ffi/primitives](https://github.com/dart-lang/samples/tree/master/ffi/primitives) |
| [_03_struct.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/_03_struct.dart) | [struct_lib](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/native_libs/struct_lib/struct.c)   | Same as [ffi/struct](https://github.com/dart-lang/samples/tree/master/ffi/structs)         |
| [_04_cxx_class_import.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/_04_cxx_class_import.dart)  | [cxx_class](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/native_libs/cxx_class/cxx_class/CxxClass.ixx)  | C++20 Module and Dart import class example |
| [_05_delphi_lib.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/_05_delphi_lib.dart) | [delphi_lib](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/native_libs/delphi_lib/delphi_lib.dpr) | Delphi simple example |
| [_06_delphi_callback.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/_06_delphi_callback.dart) | [delphi_callback](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/native_libs/delphi_callback/delphi_callback.dpr) | Call dart function from delphi |
| [_07_delphi_gui.dart](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/bin/07_delphi_gui.dart) | [delphi_app](https://github.com/ilopX/connecting_dart_lang_with_others/blob/main/native_libs/delphi_app/Unit4.pas) | Communication between Dart and Delphi gui using sockets ![image](https://user-images.githubusercontent.com/8049534/127860273-23200653-5925-4eaa-96cd-926bbabd6d5b.png) | 
