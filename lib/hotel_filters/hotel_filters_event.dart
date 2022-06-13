abstract class HotelFiltersEvent {}

class WifiChanged extends HotelFiltersEvent {
  final bool wifi;
  WifiChanged({required this.wifi});
}

class FreeParkingChanged extends HotelFiltersEvent {
  final bool freeParking;
  FreeParkingChanged({required this.freeParking});
}

class FreeCancellationChanged extends HotelFiltersEvent {
  final bool freeCancellation;
  FreeCancellationChanged({required this.freeCancellation});
}

class KitchenChanged extends HotelFiltersEvent {
  final bool kitchen;
  KitchenChanged({required this.kitchen});
}

class WashingMachineChanged extends HotelFiltersEvent {
  final bool washingMachine;
  WashingMachineChanged({required this.washingMachine});
}

class BreakfastChanged extends HotelFiltersEvent {
  final bool breakfast;
  BreakfastChanged({required this.breakfast});
}

class ACChanged extends HotelFiltersEvent {
  final bool ac;
  ACChanged({required this.ac});
}

class EntirePlaceChanged extends HotelFiltersEvent {
  final bool entirePlace;
  EntirePlaceChanged({required this.entirePlace});
}

class PrivateRoomChanged extends HotelFiltersEvent {
  final bool privateRoom;
  PrivateRoomChanged({required this.privateRoom});
}

class SharedRoomChanged extends HotelFiltersEvent {
  final bool sharedRoom;
  SharedRoomChanged({required this.sharedRoom});
}

class HotelRoomChanged extends HotelFiltersEvent {
  final bool hotelRoom;
  HotelRoomChanged({required this.hotelRoom});
}

class MinPriceChanged extends HotelFiltersEvent {
  final int minPrice;
  MinPriceChanged({required this.minPrice});
}

class MaxPriceChanged extends HotelFiltersEvent {
  final int maxPrice;
  MaxPriceChanged({required this.maxPrice});
}

class FilterSubmitted extends HotelFiltersEvent {}
