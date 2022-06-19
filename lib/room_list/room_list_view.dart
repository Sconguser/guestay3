import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/models/room_attributes.dart';
import 'package:guestay/room_list/room_list_bloc.dart';
import 'package:guestay/room_list/room_list_event.dart';
import 'package:guestay/room_list/room_list_navigator_cubit.dart';
import 'package:guestay/room_list/room_list_repository.dart';
import 'package:guestay/room_list/room_list_state.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/shared/divider.dart';

import '../hotel_search/hotel_search_repository.dart';
import '../shared/spinner.dart';

class RoomListView extends StatelessWidget {
  RoomListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RoomListBloc(
          roomListRepository: context.read<RoomListRepository>(),
        )..add(
            LoadRoomList(
                offerId:
                    context.read<HotelSearchRepository>().selectedHotel!.id,
                hotelFilters:
                    context.read<HotelSearchRepository>().hotelFilters),
          ),
        child: Container(
          decoration: backgroundDecoration,
          width: 1000,
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                containerAppBar(context, 'Available rooms', true),
                textFieldDivider,
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
          ? defaultGuestaySpinner()
          : SizedBox(height: 670, child: roomBuilder());
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
                height: 200,
                child: Card(
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(context
                                      .read<RoomListRepository>()
                                      .roomsList
                                      .elementAt(index)
                                      .roomAttributes!
                                      .name!),
                                  SizedBox(height: 10),
                                  Text('Price per night:'),
                                  Text(
                                    '${context.read<RoomListRepository>().roomsList.elementAt(index).roomAttributes!.pricePerDay.toString()} zł',
                                  ),
                                  SizedBox(height: 10),
                                  Text('Guests:'),
                                  Text(context
                                      .read<RoomListRepository>()
                                      .roomsList
                                      .elementAt(index)
                                      .roomAttributes!
                                      .guests
                                      .toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Amenities:'),
                                  attributesIcons(context
                                      .read<RoomListRepository>()
                                      .roomsList
                                      .elementAt(index)
                                      .roomAttributes!),
                                ],
                              )
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 150,
                              width: 230,
                              child: Image.asset(
                                  'assets/images/${context.read<RoomListRepository>().roomsList.elementAt(index).roomAttributes!.name!.toLowerCase()}.jpg'),
                            ),
                          )
                        ],
                      ),
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
