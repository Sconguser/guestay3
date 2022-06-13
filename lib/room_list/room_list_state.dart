import 'package:guestay/room_list/room_list_repository.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';

import '../models/room.dart';

// class RoomListState {
//   String? selectedRoom;
//   double? amountToBePaid;
//   bool? isPaid;
//   PaymentType? type;
//   List<Room>? roomList;
//   bool? isRoomListLoading = true;
//   RoomListState({
//     selectedRoom,
//     amountToBePaid,
//     isPaid,
//     type,
//     List<Room>? roomList,
//     bool? isRoomListLoading,
//   })  : this.selectedRoom = selectedRoom,
//         this.amountToBePaid = amountToBePaid,
//         this.isPaid = isPaid,
//         this.type = type,
//         this.roomList = roomList,
//         this.isRoomListLoading = isRoomListLoading;
//   RoomListState copyWith({
//     String? selectedRoom,
//     double? amountToBePaid,
//     bool? isPaid,
//     PaymentType? type,
//     List<Room>? roomList,
//     bool? isRoomListLoading,
//   }) {
//     return RoomListState(
//       selectedRoom: selectedRoom ?? this.selectedRoom,
//       amountToBePaid: amountToBePaid ?? this.amountToBePaid,
//       isPaid: isPaid ?? this.isPaid,
//       type: type ?? this.type,
//       roomList: roomList ?? this.roomList,
//     );
//   }
// }
class RoomListState {
  List<Room>? rooms;
  bool isRoomListLoading = true;
  // HomeState({
  //   required List<City> cities,
  // }) : this.cities = cities;
  RoomListState({
    List<Room>? rooms,
    required bool isRoomListLoading,
  })  : this.rooms = rooms,
        this.isRoomListLoading = isRoomListLoading;

  RoomListState copyWith({List<Room>? rooms, required bool isRoomListLoading}) {
    return RoomListState(
      rooms: rooms ?? this.rooms,
      isRoomListLoading: isRoomListLoading,
    );
  }
}
