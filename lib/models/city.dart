class City {
  int? id;
  String? name;
  City({required this.id, required this.name});

  City.fromJson(Map<String, dynamic> header, Map<String, dynamic> body) {
    id = body['id'];
    name = body['name'];
  }
}
