 #include <dart_api_dl.h>
 #include <dart_api.h>

//#include <cstdint>
#define Export extern "C" __declspec(dllexport)

//typedef int64_t Dart_Port_DL;

Dart_Port_DL _port;

Export void applyPort(Dart_Port_DL portId) {
    _port = portId;
}

Export void sendPortInt() {
   Dart_PostInteger(_port, 123456789);
}

Export void sendPortString() {
    auto str = Dart_NewStringFromCString("hello from dll");
    Dart_Post(_port, str);
}

