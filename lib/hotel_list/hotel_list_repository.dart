import 'dart:convert';
import 'package:guestay/auth/user.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/shared/utils.dart';
import 'package:http/http.dart' as http;

import '../models/city.dart';
import '../models/offer.dart';

class HotelListRepository {
  User? user;
  List<Offer> _offersList = [];
  List<Offer> get offersList => _offersList;
  final String url = 'morning-coast-93264.herokuapp.com';
  final String urlIndexOffers = '/offers';

  bool wasInitialized = false;

  Future<List<Offer>> getOffersForCity(
    int cityId,
    DateTime? startDate,
    DateTime? endDate,
    int? maxPrice,
  ) async {
    Map<String, dynamic> queryParameters = {};
    if (startDate != null && endDate != null) {
      queryParameters.putIfAbsent(
          'start_date', () => formatDateWithDates(startDate));
      queryParameters.putIfAbsent(
          'end_date', () => formatDateWithDates(endDate));
    }
    if (maxPrice != null) {
      queryParameters.putIfAbsent('max_price', () => maxPrice);
    }
    queryParameters.putIfAbsent('with_city', () => cityId.toString());
    try {
      final response = await http.get(
        Uri.https(url, urlIndexOffers, queryParameters),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("Offer list repository ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _offersList.clear();
        // print(response.body);
        for (int i = 0; i < jsonDecode(response.body)['data'].length; i++) {
          Offer newOffer = Offer.fromJson(
              response.headers, jsonDecode(response.body)['data'][i]);
          // _offersList.add(
          //     Offer.fromJson(response.headers, jsonDecode(response.body)[i]));
          if (newOffer.checkForAnyNull()) continue;
          _offersList.add(newOffer);
        }
        wasInitialized = true;
        return _offersList;
      } else {
        throw Exception('Could not get list of offers');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
