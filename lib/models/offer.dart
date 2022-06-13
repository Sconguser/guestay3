class Offer {
  int? id;
  // int? userId;
  // int? cityId;
  String? name;
  String? description;
  String? offerType;
  Offer({
    required this.id,
    // required this.userId,
    // required this.cityId,
    required this.name,
    required this.description,
    required this.offerType,
  });

  Offer.fromJson(Map<String, dynamic> header, Map<String, dynamic> body) {
    id = int.parse(body['id']);
    // cityId = body['relationships']['city_id'];
    name = body['attributes']['name'];
    description = body['attributes']['description'];
    offerType = body['attributes']['offer_type'];
  }

  bool checkForAnyNull() {
    if (id == null ||
        name == null ||
        description == null ||
        offerType == null) {
      return true;
    }
    return false;
  }
}
