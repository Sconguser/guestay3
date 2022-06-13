import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_filters/hotel_filters_view.dart';
import 'package:guestay/room_list/room_list_navigator.dart';

import '../hotel_search/hotel_search_navigator_cubit.dart';
import '../hotel_search/hotel_search_repository.dart';
import 'hotel_list_navigator_cubit.dart';
import 'hotel_list_view.dart';

class HotelListNavigator extends StatelessWidget {
  const HotelListNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return BlocProvider(
      create: (context) =>
          HotelListNavigatorCubit(hotelSearchRepository: hotelSearchRepository),
      child: BlocBuilder<HotelListNavigatorCubit, HotelListNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: HotelListView()),
              if (state == HotelListNavigatorState.hotelFilters)
                MaterialPage(child: HotelFiltersView()),
              if (state == HotelListNavigatorState.roomList)
                MaterialPage(child: RoomListNavigator()),
            ],
            onPopPage: (route, result) {
              context.read<HotelSearchNavigatorCubit>().showDefaultView();
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
