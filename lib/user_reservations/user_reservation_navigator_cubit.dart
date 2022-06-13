import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/booking_confirmation/draft_reservation_repository.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/room_list/room_list_repository.dart';

import '../models/room.dart';

enum UserReservationNavigatorState {
  defaultView,
}

class UserReservationNavigatorCubit
    extends Cubit<UserReservationNavigatorState> {
  UserReservationNavigatorCubit()
      : super(UserReservationNavigatorState.defaultView);

  void showDefaultView() => emit(UserReservationNavigatorState.defaultView);
}
