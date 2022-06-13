import 'package:flutter/cupertino.dart';

import '../hotel_filters/hotel_filters.dart';

class RoomAttributes {
  HotelFilters? hotelFilters;
  int? guests;
  double? pricePerDay;
  String? name;
  RoomAttributes.fromJson(Map<String, dynamic> attributes) {
    guests = attributes['guests'];
    pricePerDay = double.parse(attributes['price_per_day']);
    name = attributes['name'];
    hotelFilters = HotelFilters.fromJson(attributes);
  }
}
