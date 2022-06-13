import 'package:guestay/models/room_attributes.dart';

import '../hotel_filters/hotel_filters.dart';

class Room {
  int? id;
  String? type;
  RoomAttributes? roomAttributes;
  Room({
    required this.id,
  });

  Room.fromJson(Map<String, dynamic> header, Map<String, dynamic> body) {
    id = int.parse(body['id']);
    type = body['type'];
    roomAttributes = RoomAttributes.fromJson(body['attributes']);
  }
}
