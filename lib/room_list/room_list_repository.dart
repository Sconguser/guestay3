import 'dart:convert';
import 'package:guestay/auth/user.dart';
import 'package:guestay/hotel_filters/hotel_filters.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:http/http.dart' as http;

import '../models/city.dart';
import '../models/offer.dart';
import '../models/room.dart';

class RoomListRepository {
  User? user;
  List<Room> _roomsList = [];
  List<Room> get roomsList => _roomsList;
  final String url = 'morning-coast-93264.herokuapp.com';
  final String urlIndexOffers = '/rooms.json';

  bool wasInitialized = false;

  Future<List<Room>> getRoomsForOffer(
      int offerId, HotelFilters? hotelFilters) async {
    // final queryParameters = {
    //   'with_offer': offerId.toString(),
    // };
    Map<String, dynamic> queryParameters = {};
    if (hotelFilters != null) {
      addFiltersToQueryParameters(hotelFilters, queryParameters);
    }
    queryParameters.putIfAbsent("with_offer", () => offerId.toString());
    try {
      final response = await http.get(
        Uri.https(url, urlIndexOffers, queryParameters),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("Room list repository ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _roomsList.clear();
        // print(response.body);
        for (int i = 0; i < jsonDecode(response.body)['data'].length; i++) {
          Room newRoom = Room.fromJson(
              response.headers, jsonDecode(response.body)['data'][i]);
          // if (newRoom.checkForAnyNull()) continue;
          _roomsList.add(newRoom);
        }
        wasInitialized = true;
        return _roomsList;
      } else {
        throw Exception('Could not get list of rooms');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void addFiltersToQueryParameters(
      HotelFilters? hotelFilters, Map<String, dynamic> queryParameters) {
    if (hotelFilters != null) {
      if (hotelFilters.kitchen != null && hotelFilters.kitchen!) {
        queryParameters.putIfAbsent('with_kitchen', () => 'true');
      }
      if (hotelFilters.breakfast != null && hotelFilters.breakfast!) {
        queryParameters.putIfAbsent('with_breakfast', () => 'true');
      }
      if (hotelFilters.ac != null && hotelFilters.ac!) {
        queryParameters.putIfAbsent('with_ac', () => 'true');
      }
      if (hotelFilters.wifi != null && hotelFilters.wifi!) {
        queryParameters.putIfAbsent('with_wifi', () => 'true');
      }
      if (hotelFilters.maxPrice != null) {
        queryParameters.putIfAbsent(
            'with_max_price', () => hotelFilters.maxPrice.toString());
      }
    }
  }
}
