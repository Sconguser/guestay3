abstract class ReservationEvent {}

class LoadUserReservation extends ReservationEvent {
  String bearerToken;

  LoadUserReservation({required this.bearerToken});
}
