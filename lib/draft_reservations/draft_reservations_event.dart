abstract class DraftReservationsEvent {}

class LoadDraftReservations extends DraftReservationsEvent {
  String bearerToken;
  LoadDraftReservations({required this.bearerToken});
}
