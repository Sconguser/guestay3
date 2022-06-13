import 'package:flutter/material.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/models/draft_reservation.dart';

class BookingConfirmationState {
  HotelSearchRepository hotelSearchRepository;
  DraftReservation? draftReservation;
  bool isDraftBeingCreated;

  BookingConfirmationState(
      {DraftReservation? draftReservation,
      required bool isDraftBeingCreated,
      required HotelSearchRepository hotelSearchRepository})
      : this.draftReservation = draftReservation,
        this.isDraftBeingCreated = isDraftBeingCreated,
        this.hotelSearchRepository = hotelSearchRepository;

  BookingConfirmationState copyWith(
      {DraftReservation? draftReservation, required bool isDraftBeingCreated}) {
    return BookingConfirmationState(
      draftReservation: draftReservation ?? this.draftReservation,
      isDraftBeingCreated: isDraftBeingCreated,
      hotelSearchRepository: this.hotelSearchRepository,
    );
  }
}
