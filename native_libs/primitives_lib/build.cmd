mkdir tmp
cd tmp
call "cmake" -G "Visual Studio 16 2019" ..
call "MSBuild.exe" primitives_lib.sln /property:Configuration=Release
cd ..
mkdir build

xcopy /s tmp\Release build
del build\primitives_lib.exp
del build\primitives_lib.lib

del /s /q tmp
rmdir /s /q tmp
