import 'package:guestay/hotel_search/hotel_search_repository.dart';

class Reservation {
  int? id;
  double? finalPrice;
  double? pricePerDay;
  DateTime? startDate;
  DateTime? endDate;
  PaymentType? paymentType;
  String? roomName;
  int? numberOfDays;

  Reservation({
    required this.id,
    required this.finalPrice,
    required this.pricePerDay,
    required this.startDate,
    required this.endDate,
    required this.paymentType,
    required this.roomName,
    required this.numberOfDays,
  });

  Reservation.fromJson(Map<String, dynamic> header, Map<String, dynamic> body) {
    id = int.parse(body['id']);
    startDate = DateTime.parse(body['attributes']['start_date']);
    endDate = DateTime.parse(body['attributes']['end_date']);
    finalPrice = double.parse(body['attributes']['price']);
    pricePerDay = double.parse(body['attributes']['price_per_day']);
    numberOfDays = body['attributes']['number_of_days'];
    paymentType = HotelSearchRepository.stringToPaymentType(
        body['attributes']['payment_type']);
    roomName = body['attributes']['room_name'];
  }
}
