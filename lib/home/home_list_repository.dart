import 'dart:convert';
import 'package:guestay/auth/user.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:http/http.dart' as http;

import '../models/city.dart';

class HomeListRepository {
  User? user;
  List<City> _citiesList = [];
  List<City> get citiesList => _citiesList;
  final String url = 'morning-coast-93264.herokuapp.com';
  final String urlIndexCities = '/cities';

  bool wasInitialized = false;

  Future<List<City>> getCities() async {
    try {
      final response = await http.get(
        Uri.https(url, urlIndexCities),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("Home list repository ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _citiesList.clear();
        print(response.body);
        for (int i = 0; i < jsonDecode(response.body).length; i++) {
          _citiesList.add(
              City.fromJson(response.headers, jsonDecode(response.body)[i]));
        }
        wasInitialized = true;
        return _citiesList;
      } else {
        throw Exception('Could not get list of cities');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
