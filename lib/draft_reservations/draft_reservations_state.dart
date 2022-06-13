import '../models/draft_reservation.dart';
import '../models/reservation.dart';

class DraftReservationsState {
  List<DraftReservation>? draftReservations;
  bool isDraftReservationListLoading = true;
  DraftReservationsState({
    List<DraftReservation>? draftReservations,
    required bool isDraftReservationListLoading,
  })  : this.draftReservations = draftReservations,
        this.isDraftReservationListLoading = isDraftReservationListLoading;

  DraftReservationsState copyWith(
      {List<DraftReservation>? draftReservations,
      required bool isDraftReservationListLoading}) {
    return DraftReservationsState(
      draftReservations: draftReservations ?? this.draftReservations,
      isDraftReservationListLoading: isDraftReservationListLoading,
    );
  }
}
