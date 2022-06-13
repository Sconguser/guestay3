import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/models/room_attributes.dart';
import 'package:guestay/room_list/room_list_bloc.dart';
import 'package:guestay/room_list/room_list_event.dart';
import 'package:guestay/room_list/room_list_navigator_cubit.dart';
import 'package:guestay/room_list/room_list_repository.dart';
import 'package:guestay/room_list/room_list_state.dart';
import 'package:guestay/shared/constants/background.dart';

import '../hotel_search/hotel_search_repository.dart';

List<String> rooms = [
  'Economy single room',
  'Economy double room',
  'Standard single room',
  'Standard double room',
  'Premium single room',
  'Premium double room',
  'Meh',
  'Meh2',
];

class RoomListView extends StatelessWidget {
  RoomListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => RoomListBloc(
          roomListRepository: context.read<RoomListRepository>(),
        )..add(LoadRoomList(
            offerId: context.read<HotelSearchRepository>().selectedHotel!.id)),
        child: Container(
          decoration: backgroundDecoration,
          width: 1000,
          padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                roomList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget roomList() {
    return BlocBuilder<RoomListBloc, RoomListState>(builder: (context, state) {
      return state.isRoomListLoading
          ? CircularProgressIndicator()
          : SizedBox(height: 490, child: roomBuilder());
    });
  }

  Widget roomBuilder() {
    return BlocBuilder<RoomListBloc, RoomListState>(builder: (context, state) {
      return ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: context.read<RoomListRepository>().roomsList.length,
        itemBuilder: (BuildContext context, int index) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InkWell(
              onTap: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'You chose ${context.read<RoomListRepository>().roomsList.elementAt(index).roomAttributes!.name!}'),
                ));
                context.read<RoomListNavigatorCubit>().confirmSelectedRoom(
                    context
                        .read<RoomListRepository>()
                        .roomsList
                        .elementAt(index));
              },
              child: SizedBox(
                height: 100,
                child: Card(
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(context
                            .read<RoomListRepository>()
                            .roomsList
                            .elementAt(index)
                            .roomAttributes!
                            .name!),
                        attributesIcons(context
                            .read<RoomListRepository>()
                            .roomsList
                            .elementAt(index)
                            .roomAttributes!)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget attributesIcons(RoomAttributes attributes) {
    return Row(
      children: [
        // attributes.hotelFilters!.breakfast!
        //     ? Icon(Icons.coffee)
        //     : SizedBox.shrink(),
        attributes.hotelFilters!.wifi! ? Icon(Icons.wifi) : SizedBox.shrink(),
        // attributes.hotelFilters!.freeParking!
        //     ? Icon(Icons.local_parking)
        //     : SizedBox.shrink(),
        attributes.hotelFilters!.kitchen!
            ? Icon(Icons.kitchen)
            : SizedBox.shrink(),
        attributes.hotelFilters!.ac! ? Icon(Icons.ac_unit) : SizedBox.shrink(),
        // attributes.hotelFilters!.freeCancellation!
        //     ? Icon(Icons.cancel_outlined)
        //     : SizedBox.shrink(),
      ],
    );
  }
}
