abstract class HotelListEvent {}

class LoadOfferList extends HotelListEvent {
  final int cityId;

  LoadOfferList({required this.cityId});
}

// class LoginSubmitted extends LoginEvent {}
