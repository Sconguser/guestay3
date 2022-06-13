import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guestay/auth/user.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:http/http.dart' as http;

import '../models/city.dart';
import '../models/draft_reservation.dart';
import '../models/offer.dart';

class DraftReservationRepository {
  User? user;
  List<DraftReservation> _draftReservationList = [];
  List<DraftReservation> get draftReservationList => _draftReservationList;

  int? roomId;
  DateTime? startDate;
  DateTime? endDate;

  final String url = 'morning-coast-93264.herokuapp.com';
  final String urlCreateDraftReservation = '/draft_reservations';
  final String urlGetDraftReservations = '/my/draft_reservations.json';

  Future<DraftReservation> createDraftReservation(
    int roomId,
    DateTime startDate,
    DateTime endDate,
    String bearerToken,
  ) async {
    var startFormatted =
        "${startDate.year}-${startDate.month}-${startDate.day}";
    var endFormatted = "${endDate.year}-${endDate.month}-${endDate.day}";

    try {
      final response =
          await http.post(Uri.https(url, urlCreateDraftReservation),
              headers: <String, String>{
                'Authorization': bearerToken,
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                "draft_reservations": <String, dynamic>{
                  'room_id': roomId,
                  'start_date': startFormatted,
                  'end_date': endFormatted,
                },
              }));
      print("Draft creation repository ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        DraftReservation newDraftReservation = DraftReservation.fromJson(
            response.headers, jsonDecode(response.body)['data']);
        draftReservationList.add(newDraftReservation);
        return newDraftReservation;
      } else if (response.statusCode == 422) {
        throw Exception('Uzytkownik nie moze miec wiecej niz 10 draftow');
      } else {
        throw Exception('Could not create new Draft Reservation');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<DraftReservation>> getDraftReservations(
    String bearerToken,
  ) async {
    try {
      final response = await http.get(
        Uri.https(url, urlGetDraftReservations),
        headers: <String, String>{
          'Authorization': bearerToken,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("draft reservation get repository ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        for (int i = 0; i < jsonDecode(response.body)['data'].length; i++) {
          DraftReservation newDraftReservation = DraftReservation.fromJson(
              response.headers, jsonDecode(response.body)['data'][i]);
          draftReservationList.add(newDraftReservation);
        }
        return draftReservationList;
      } else {
        throw Exception('Could not get reservation list');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
