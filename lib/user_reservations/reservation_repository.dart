import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guestay/auth/user.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:http/http.dart' as http;

import '../models/city.dart';
import '../models/draft_reservation.dart';
import '../models/offer.dart';
import '../models/reservation.dart';

class ReservationRepository {
  User? user;
  List<Reservation> _reservationList = [];
  List<Reservation> get reservationList => _reservationList;
  final String url = 'morning-coast-93264.herokuapp.com';
  final String urlCreateReservation = '/reservations';
  final String urlGetReservations = '/my/reservations.json';

  Future<void> createReservation(
    int draftReservationId,
    String paymentTypeId,
    int price,
    String bearerToken,
  ) async {
    try {
      final response = await http.post(Uri.https(url, urlCreateReservation),
          headers: <String, String>{
            'Authorization': bearerToken,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "reservation": <String, dynamic>{
              'draft_reservation_id': draftReservationId,
              'payment_type_id': paymentTypeId,
              'price': price,
            },
          }));
      print("reservation creation repository ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        // Reservation newReservation =
        //     Reservation.fromJson(response.headers, jsonDecode(response.body));
        // reservationList.add(newReservation);
        // return newReservation;
      } else {
        throw Exception('Could not create new Reservation');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Reservation>> getUserReservations(
    String bearerToken,
  ) async {
    try {
      final response = await http.get(
        Uri.https(url, urlGetReservations),
        headers: <String, String>{
          'Authorization': bearerToken,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("reservation get repository ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        for (int i = 0; i < jsonDecode(response.body)['data'].length; i++) {
          Reservation newReservation = Reservation.fromJson(
              response.headers, jsonDecode(response.body)['data'][i]);
          reservationList.add(newReservation);
        }
        return reservationList;
      } else {
        throw Exception('Could not get reservation list');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
