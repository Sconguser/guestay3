import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';

import '../hotel_filters/hotel_filters.dart';
import 'package:guestay/models/offer.dart';

enum HotelListNavigatorState { defaultView, hotelFilters, roomList }

class HotelListNavigatorCubit extends Cubit<HotelListNavigatorState> {
  final HotelSearchRepository hotelSearchRepository;
  HotelListNavigatorCubit({required this.hotelSearchRepository})
      : super(HotelListNavigatorState.defaultView);

  //TODO dokonczyc to
  void confirmChosenFilters(
    bool wifi,
    bool freeParking,
    bool freeCancellation,
    bool kitchen,
    bool washingMachine,
    bool breakfast,
    bool entirePlace,
    bool privateRoom,
    bool sharedRoom,
    bool hotelRoom,
    int? maxPrice,
    int? minPrice,
  ) {
    hotelSearchRepository.setHotelFilters(HotelFilters(
      wifi: wifi,
      freeParking: freeParking,
      freeCancellation: freeCancellation,
      kitchen: kitchen,
      washingMachine: washingMachine,
      breakfast: breakfast,
      entirePlace: entirePlace,
      privateRoom: privateRoom,
      sharedRoom: sharedRoom,
      hotelRoom: hotelRoom,
      maxPrice: maxPrice,
      minPrice: minPrice,
    ));
    showDefaultView();
  }

  void confirmSelectedHotel(Offer? selectedHotel) {
    if (selectedHotel == null) {
      return;
    }
    hotelSearchRepository.setSelectedHotel(selectedHotel);
    showRoomList();
  }

  void showDefaultView() => emit(HotelListNavigatorState.defaultView);
  void showHotelFilters() => emit(HotelListNavigatorState.hotelFilters);
  void showRoomList() => emit(HotelListNavigatorState.roomList);
}
