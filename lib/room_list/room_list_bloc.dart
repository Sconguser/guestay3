import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/room_list/room_list_event.dart';
import 'package:guestay/room_list/room_list_repository.dart';
import '../models/room.dart';
import 'room_list_state.dart';

class RoomListBloc extends Bloc<RoomListEvent, RoomListState> {
  final RoomListRepository roomListRepository;
  RoomListBloc({
    required this.roomListRepository,
  }) : super(RoomListState(
          isRoomListLoading: true,
        )) {
    on<LoadRoomList>((event, emit) async {
      emit(
        state.copyWith(isRoomListLoading: true),
      );
      try {
        List<Room> roomList = await roomListRepository.getRoomsForOffer(
            event.offerId, event.hotelFilters);
        emit(state.copyWith(rooms: roomList, isRoomListLoading: false));
      } catch (e) {
        print('NIE UDALO SIE ZALADOWAC LISTY POKOJOW $e');
      }
    });
  }
}
