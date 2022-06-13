import 'package:flutter_bloc/flutter_bloc.dart';
import '../booking_confirmation/draft_reservation_repository.dart';
import '../models/draft_reservation.dart';
import 'draft_reservations_event.dart';
import 'draft_reservations_state.dart';

class DraftReservationBloc
    extends Bloc<DraftReservationsEvent, DraftReservationsState> {
  final DraftReservationRepository draftReservationRepository;
  DraftReservationBloc({
    required this.draftReservationRepository,
  }) : super(DraftReservationsState(
          isDraftReservationListLoading: true,
        )) {
    on<LoadDraftReservations>((event, emit) async {
      emit(
        state.copyWith(isDraftReservationListLoading: true),
      );
      try {
        List<DraftReservation> draftReservations =
            await draftReservationRepository
                .getDraftReservations(event.bearerToken);
        emit(state.copyWith(
            draftReservations: draftReservations,
            isDraftReservationListLoading: false));
      } catch (e) {
        print('NIE UDALO SIE ZALADOWAC LISTY DRAFTOW $e');
      }
    });
  }
}
