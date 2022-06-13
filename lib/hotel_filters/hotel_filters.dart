import 'package:flutter/material.dart';

class HotelFilters {
  bool? wifi;
  bool? freeParking;
  bool? freeCancellation;
  bool? kitchen;
  bool? washingMachine;
  bool? breakfast;
  bool? ac;
  bool? entirePlace;
  bool? privateRoom;
  bool? sharedRoom;
  bool? hotelRoom;
  int? minPrice;
  int? maxPrice;

  HotelFilters({
    this.wifi,
    this.freeParking,
    this.freeCancellation,
    this.kitchen,
    this.washingMachine,
    this.breakfast,
    this.ac,
    this.entirePlace,
    this.privateRoom,
    this.sharedRoom,
    this.hotelRoom,
    this.minPrice,
    this.maxPrice,
  });
  void setChosenFilters(
    bool? wifi,
    bool? freeParking,
    bool? freeCancellation,
    bool? kitchen,
    bool? washingMachine,
    bool? breakfast,
    bool? ac,
    bool? entirePlace,
    bool? privateRoom,
    bool? sharedRoom,
    bool? hotelRoom,
    int? minPrice,
    int? maxPrice,
  ) {
    this.wifi = wifi;
    this.freeParking = freeParking;
    this.freeCancellation = freeCancellation;
    this.kitchen = kitchen;
    this.washingMachine = washingMachine;
    this.breakfast = breakfast;
    this.ac = ac;
    this.entirePlace = entirePlace;
    this.privateRoom = privateRoom;
    this.sharedRoom = sharedRoom;
    this.hotelRoom = hotelRoom;
    this.minPrice = minPrice;
    this.maxPrice = maxPrice;
  }

  /// TODO: sprawdzic
  HotelFilters.fromJson(Map<String, dynamic> attributes) {
    wifi = attributes['wifi'];
    freeParking = attributes['free_parking'];
    freeCancellation = attributes['free_cancellation'];
    kitchen = attributes['self_kitchen'];
    washingMachine = attributes['washing_machine'];
    breakfast = attributes['breakfast'];
    ac = attributes['ac'];
  }
}
