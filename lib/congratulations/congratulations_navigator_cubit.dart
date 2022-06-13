import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';

enum CongratulationsNavigatorState {
  defaultView,
}

class CongratulationsNavigatorCubit
    extends Cubit<CongratulationsNavigatorState> {
  HotelSearchRepository hotelSearchRepository;
  CongratulationsNavigatorCubit({required this.hotelSearchRepository})
      : super(CongratulationsNavigatorState.defaultView);

  void showDefaultView() => emit(CongratulationsNavigatorState.defaultView);
}
