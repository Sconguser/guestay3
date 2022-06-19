abstract class HotelListEvent {}

class LoadOfferList extends HotelListEvent {
  final int cityId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? maxPrice;
  LoadOfferList(
      {required this.cityId, this.startDate, this.endDate, this.maxPrice});
}

// class LoginSubmitted extends LoginEvent {}
