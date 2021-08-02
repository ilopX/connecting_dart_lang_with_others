echo off
cls

:: prepare
mkdir tmp
cd tmp
call "cmake" -G "Visual Studio 16 2019" ..
call "cmake" --build . --target ALL_BUILD --config Release

cd ..
mkdir build
xcopy /s tmp\Release build

:: clear
del build\struct_lib.exp
del build\struct_lib.lib
del /s /q tmp
rmdir /s /q tmp
