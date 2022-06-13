import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/auth_repository.dart';
import 'package:guestay/booking_confirmation/booking_confirmation_event.dart';
import 'package:guestay/booking_confirmation/booking_confirmation_state.dart';
import 'package:guestay/booking_confirmation/draft_reservation_repository.dart';
import 'package:guestay/hotel_search/hotel_search_navigator_cubit.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/models/draft_reservation.dart';

class BookingConfirmationBloc
    extends Bloc<BookingConfirmationEvent, BookingConfirmationState> {
  final DraftReservationRepository draftReservationRepository;
  final AuthRepository authRepository;
  final HotelSearchRepository hotelSearchRepository;
  BookingConfirmationBloc({
    required this.draftReservationRepository,
    required this.authRepository,
    required this.hotelSearchRepository,
  }) : super(BookingConfirmationState(
            isDraftBeingCreated: true,
            hotelSearchRepository: hotelSearchRepository)) {
    on<CreateDraftReservation>((event, emit) async {
      emit(
        state.copyWith(isDraftBeingCreated: true),
      );
      try {
        DraftReservation draftReservation =
            await draftReservationRepository.createDraftReservation(
                event.id,
                event.startDate,
                event.endDate,
                authRepository.user.bearerToken!);
        emit(state.copyWith(
            draftReservation: draftReservation, isDraftBeingCreated: false));
      } catch (e) {
        print("NIE UDALO SIE STWORZYC DRAFT RESERVATION $e");
      }
    });
  }
}
