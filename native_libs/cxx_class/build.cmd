
call "MSBuild.exe" cxx_class\cxx_class.vcxproj /p:Configuration="Release"  /p:Platform=X64

mkdir build
cd build

copy  ..\cxx_class\X64\Release\cxx_class.dll cxx_class.dll 
del /s /q ..\cxx_class\X64\
rmdir /s /q ..\cxx_class\X64\
