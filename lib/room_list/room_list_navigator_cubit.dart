import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/booking_confirmation/draft_reservation_repository.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/room_list/room_list_repository.dart';

import '../models/room.dart';

enum RoomListNavigatorState {
  defaultView,
  paymentChoiceView,
}

class RoomListNavigatorCubit extends Cubit<RoomListNavigatorState> {
  final HotelSearchRepository hotelSearchRepository;
  final DraftReservationRepository draftReservationRepository;

  RoomListNavigatorCubit(
      {required this.hotelSearchRepository,
      required this.draftReservationRepository})
      : super(RoomListNavigatorState.defaultView);

  void confirmSelectedRoom(Room? room) {
    if (room == null) {
      return;
    }
    hotelSearchRepository.setSelectedRoom(room);
    showPaymentChoiceView();
  }

  void showDefaultView() => emit(RoomListNavigatorState.defaultView);
  void showPaymentChoiceView() {
    draftReservationRepository.roomId = hotelSearchRepository.selectedRoom!.id;
    draftReservationRepository.startDate = hotelSearchRepository.startDate;
    draftReservationRepository.endDate = hotelSearchRepository.endDate;
    emit(RoomListNavigatorState.paymentChoiceView);
  }
}
