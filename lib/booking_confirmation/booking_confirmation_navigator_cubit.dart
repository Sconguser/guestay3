import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';

enum BookingConfirmationNavigatorState {
  defaultView,
  congratulationsView,
}

class BookingConfirmationNavigatorCubit
    extends Cubit<BookingConfirmationNavigatorState> {
  final HotelSearchRepository hotelSearchRepository;
  BookingConfirmationNavigatorCubit({required this.hotelSearchRepository})
      : super(BookingConfirmationNavigatorState.defaultView);

  void showDefaultView() => emit(BookingConfirmationNavigatorState.defaultView);
  void showCongratulations() =>
      emit(BookingConfirmationNavigatorState.congratulationsView);
}
