import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/room_list/room_list_repository.dart';

import '../booking_confirmation/draft_reservation_repository.dart';
import '../models/room.dart';

enum UserDraftReservationsNavigatorState {
  defaultView,
  finishBooking,
}

class UserDraftReservationsNavigatorCubit
    extends Cubit<UserDraftReservationsNavigatorState> {
  final DraftReservationRepository draftReservationRepository;
  UserDraftReservationsNavigatorCubit(
      {required this.draftReservationRepository})
      : super(UserDraftReservationsNavigatorState.defaultView);

  void showDefaultView() =>
      emit(UserDraftReservationsNavigatorState.defaultView);

  void finishBooking(DateTime startDate, DateTime endDate, int roomId) {
    draftReservationRepository.startDate = startDate;
    draftReservationRepository.endDate = endDate;
    draftReservationRepository.roomId = roomId;
    emit(UserDraftReservationsNavigatorState.finishBooking);
  }
}
