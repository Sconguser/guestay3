import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/booking_confirmation/draft_reservation_repository.dart';
import 'package:guestay/draft_reservations/user_draft_reservations_navigator_cubit.dart';
import 'package:guestay/draft_reservations/user_draft_reservations_view.dart';
import 'package:guestay/hotel_list/hotel_list_navigator_cubit.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/room_list/room_list_navigator_cubit.dart';
import 'package:guestay/room_list/room_list_view.dart';
import 'package:guestay/room_list/room_list_repository.dart';
import 'package:guestay/user_reservations/user_reservation_navigator_cubit.dart';
import 'package:guestay/user_reservations/user_reservations_view.dart';

import '../payment_choice/payment_choice_navigator.dart';

class UserDraftReservationsNavigator extends StatelessWidget {
  const UserDraftReservationsNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // RoomRepository roomRepository = context.read<RoomRepository>();
    DraftReservationRepository draftReservationRepository =
        context.read<DraftReservationRepository>();
    return BlocProvider(
      create: (context) => UserDraftReservationsNavigatorCubit(
          draftReservationRepository: draftReservationRepository),
      child: BlocBuilder<UserDraftReservationsNavigatorCubit,
          UserDraftReservationsNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: UserDraftReservationsView()),
              if (state == UserDraftReservationsNavigatorState.finishBooking)
                MaterialPage(child: (PaymentChoiceNavigator())),
              // if (state == RoomListNavigatorState.paymentChoiceView)
              //   MaterialPage(child: PaymentChoiceNavigator()),
            ],
            onPopPage: (route, result) {
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
