import 'dart:ffi';

import 'package:ffi_interpop_c/color_printer.dart';
import 'package:ffi_interpop_c/lib_search.dart';
import 'package:ffi/ffi.dart';

void main() async {
  final lib = await StructLib.load();

  printGreen('Output:');

  final name = lib.getName();
  print('name: $name');

  final reversedStr = lib.reverse('ilopX');
  print('reversedStr: $reversedStr');

  final coordinatePointer = lib.createCoordinate(100, 200);
  final coordinate = coordinatePointer.ref;
  calloc.free(coordinatePointer);
  print('create_coordinate() \n\t'
      'latitude: ${coordinate.latitude}\n\t'
      'longitude: ${coordinate.longitude}');

  final placePointer = lib.createPlace('Oslo'.toNativeUtf8(), 11, 22);
  final place = placePointer.ref;

  calloc.free(placePointer.ref.coordinate);
  calloc.free(placePointer);
  print('create place()\n\t'
      'name: ${place.name.toDartString()}\n\t'
      'latitude: ${place.coordinate.ref.latitude} \n\t'
      'longitude: ${place.coordinate.ref.longitude} \n\t');
}

class StructLib {
  final Dart_Get_Name _getName;
  final Dart_Reverse _reverse;
  final Dart_Create_Coordinate createCoordinate;
  final Dart_Create_Place createPlace;

  static Future<StructLib> load() async {
    final structLibFileName = await buildAndGetFileNameLib('struct_lib');
    final structLib = DynamicLibrary.open(structLibFileName);

    final getName =
    structLib.lookupFunction<
        CXX_Get_Name,
        Dart_Get_Name>('getName');

    final reverse =
    structLib.lookupFunction<CXX_Reverse,
        Dart_Reverse>('reverse');

    final createCoordinate =
    structLib.lookupFunction<
        CXX_Create_Coordinate,
        Dart_Create_Coordinate>('create_coordinate');

    final create_place =  structLib.lookupFunction<
        CXX_Create_Place,
        Dart_Create_Place>('create_place');

    return StructLib._internal(getName, reverse, createCoordinate,
      create_place);
  }

  StructLib._internal(this._getName, this._reverse, this.createCoordinate,
      this.createPlace);

  String getName() {
    return _getName().toDartString();
  }

  String reverse(String name) {
    final pointerName = name.toNativeUtf8();
    final result = _reverse(pointerName, name.length);
    final dartResult = result.toDartString();
    calloc.free( pointerName);
    calloc.free(result);
    return dartResult;
  }

}

typedef CXX_Get_Name = Pointer<Utf8> Function();
typedef Dart_Get_Name = Pointer<Utf8> Function();

typedef CXX_Reverse = Pointer<Utf8> Function(Pointer<Utf8>, Int32);
typedef Dart_Reverse = Pointer<Utf8> Function(Pointer<Utf8> str, int length);

class Coordinate extends Struct {
  @Double()
  external double latitude;

  @Double()
  external double longitude;

  factory Coordinate.allocate(double latitude, double longitude) {
    return calloc<Coordinate>().ref
      ..latitude = latitude
      ..longitude = longitude;
  }
}

typedef CXX_Create_Coordinate = Pointer<Coordinate> Function(
    Double latitude, Double longitude);

typedef Dart_Create_Coordinate = Pointer<Coordinate> Function(
    double latitude, double longitude);

class Place extends Struct {
  external Pointer<Utf8> name;
  external Pointer<Coordinate> coordinate;

  factory Place.allocate(Pointer<Utf8> name, Pointer<Coordinate> coordinate) {
    return calloc<Place>().ref
      ..coordinate = coordinate
      ..name = name;
  }
}

typedef CXX_Create_Place = Pointer<Place> Function(
    Pointer<Utf8>, Double latitude, Double longitude);

typedef Dart_Create_Place = Pointer<Place> Function(Pointer<
    Utf8> name, double latitude, double longitude);
