class DraftReservation {
  int? id;
  int? roomId;
  double? finalPrice;
  double? pricePerDay;
  int? numberOfDays;
  String? roomName;
  DateTime? startDate;
  DateTime? endDate;
  DraftReservation({
    required this.id,
    required this.roomId,
    required this.finalPrice,
    required this.startDate,
    required this.endDate,
    required this.pricePerDay,
    required this.numberOfDays,
    required this.roomName,
  });

  DraftReservation.fromJson(
      Map<String, dynamic> header, Map<String, dynamic> body) {
    id = int.parse(body['id']);
    roomId = body['attributes']['room_id'];
    startDate = DateTime.parse(body['attributes']['start_date']);
    endDate = DateTime.parse(body['attributes']['end_date']);
    finalPrice = double.parse(body['attributes']['final_price']);
    pricePerDay = double.parse(body['attributes']['price_per_day']);
    roomName = body['attributes']['room_name'];
    numberOfDays = body['attributes']['number_of_days'];
  }
}
