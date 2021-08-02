mkdir tmp
cd tmp
call "cmake" -G "Visual Studio 16 2019" ..
call "MSBuild.exe" cxx_lib.sln /property:Configuration=Release
cd ..
mkdir build
xcopy /s tmp\Release build

del build\cxx_lib.exp
del build\cxx_lib.lib

del /s /q tmp
rmdir /s /q tmp
