import '../models/reservation.dart';

class ReservationState {
  List<Reservation>? reservations;
  bool isReservationListLoading = true;
  // HomeState({
  //   required List<City> cities,
  // }) : this.cities = cities;
  ReservationState({
    List<Reservation>? reservations,
    required bool isReservationListLoading,
  })  : this.reservations = reservations,
        this.isReservationListLoading = isReservationListLoading;

  ReservationState copyWith(
      {List<Reservation>? reservations,
      required bool isReservationListLoading}) {
    return ReservationState(
      reservations: reservations ?? this.reservations,
      isReservationListLoading: isReservationListLoading,
    );
  }
}
