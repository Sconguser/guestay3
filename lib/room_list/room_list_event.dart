import 'package:guestay/hotel_filters/hotel_filters.dart';
import 'package:guestay/room_list/room_list_repository.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';

abstract class RoomListEvent {}

class LoadRoomList extends RoomListEvent {
  final offerId;
  HotelFilters? hotelFilters;
  LoadRoomList({required this.offerId, this.hotelFilters});
}
