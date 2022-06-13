import 'package:dart_numerics/dart_numerics.dart' as numerics;
import 'package:flutter/cupertino.dart';

class HotelFiltersState {
  bool? wifi;
  bool? freeParking;
  bool? freeCancellation;
  bool? kitchen;
  bool? washingMachine;
  bool? breakfast;
  bool? entirePlace;
  bool? privateRoom;
  bool? sharedRoom;
  bool? hotelRoom;
  int? minPrice;
  int? maxPrice;

  HotelFiltersState({
    this.wifi = false,
    this.freeParking = false,
    this.freeCancellation = false,
    this.kitchen = false,
    this.washingMachine = false,
    this.breakfast = false,
    this.entirePlace = false,
    this.privateRoom = false,
    this.sharedRoom = false,
    this.hotelRoom = false,
    this.maxPrice = numerics.int64MaxValue,
    this.minPrice = numerics.int64MinValue,
  });
  HotelFiltersState copyWith({
    bool? wifi,
    bool? freeParking,
    bool? freeCancellation,
    bool? kitchen,
    bool? washingMachine,
    bool? breakfast,
    bool? entirePlace,
    bool? privateRoom,
    bool? sharedRoom,
    bool? hotelRoom,
    int? maxPrice,
    int? minPrice,
  }) {
    return HotelFiltersState(
      wifi: wifi ?? this.wifi,
      freeParking: freeParking ?? this.freeParking,
      freeCancellation: freeCancellation ?? this.freeCancellation,
      kitchen: kitchen ?? this.kitchen,
      washingMachine: washingMachine ?? this.washingMachine,
      breakfast: breakfast ?? this.breakfast,
      entirePlace: entirePlace ?? this.entirePlace,
      privateRoom: privateRoom ?? this.privateRoom,
      sharedRoom: sharedRoom ?? this.sharedRoom,
      hotelRoom: hotelRoom ?? this.hotelRoom,
      maxPrice: maxPrice ?? this.maxPrice,
      minPrice: minPrice ?? this.minPrice,
    );
  }
}
