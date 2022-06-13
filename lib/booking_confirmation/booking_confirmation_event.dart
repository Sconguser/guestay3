abstract class BookingConfirmationEvent {}

class CreateDraftReservation extends BookingConfirmationEvent {
  final DateTime startDate;
  final DateTime endDate;
  final int id;

  CreateDraftReservation({
    required this.startDate,
    required this.endDate,
    required this.id,
  });
}
