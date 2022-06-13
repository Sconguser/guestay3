import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/room_list/room_list_event.dart';
import 'package:guestay/room_list/room_list_repository.dart';
import 'package:guestay/user_reservations/reservation_event.dart';
import 'package:guestay/user_reservations/reservation_repository.dart';
import 'package:guestay/user_reservations/reservation_state.dart';
import '../models/reservation.dart';
import '../models/room.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository reservationRepository;
  ReservationBloc({
    required this.reservationRepository,
  }) : super(ReservationState(
          isReservationListLoading: true,
        )) {
    on<LoadUserReservation>((event, emit) async {
      emit(
        state.copyWith(isReservationListLoading: true),
      );
      try {
        List<Reservation> reservations =
            await reservationRepository.getUserReservations(event.bearerToken);
        emit(state.copyWith(
            reservations: reservations, isReservationListLoading: false));
      } catch (e) {
        print('NIE UDALO SIE ZALADOWAC LISTY REZERWACJI $e');
      }
    });
  }
}
