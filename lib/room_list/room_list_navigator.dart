import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/booking_confirmation/draft_reservation_repository.dart';
import 'package:guestay/hotel_list/hotel_list_navigator_cubit.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/room_list/room_list_navigator_cubit.dart';
import 'package:guestay/room_list/room_list_view.dart';
import 'package:guestay/room_list/room_list_repository.dart';

import '../payment_choice/payment_choice_navigator.dart';

class RoomListNavigator extends StatelessWidget {
  const RoomListNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // RoomRepository roomRepository = context.read<RoomRepository>();
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    DraftReservationRepository draftReservationRepository =
        context.read<DraftReservationRepository>();

    return BlocProvider(
      create: (context) => RoomListNavigatorCubit(
          hotelSearchRepository: hotelSearchRepository,
          draftReservationRepository: draftReservationRepository),
      child: BlocBuilder<RoomListNavigatorCubit, RoomListNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: RoomListView()),
              if (state == RoomListNavigatorState.defaultView)
                MaterialPage(child: RoomListView()),
              if (state == RoomListNavigatorState.paymentChoiceView)
                MaterialPage(child: PaymentChoiceNavigator()),
            ],
            onPopPage: (route, result) {
              context.read<HotelListNavigatorCubit>().showDefaultView();
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
