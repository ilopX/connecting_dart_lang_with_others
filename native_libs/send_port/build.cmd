call "MSBuild.exe" send_port\send_port.vcxproj /p:Configuration="Release"  /p:Platform=X64

mkdir build
cd build

copy  ..\send_port\X64\Release\send_port.dll send_port.dll
del /s /q ..\send_port\X64\
rmdir /s /q ..\send_port\X64\
