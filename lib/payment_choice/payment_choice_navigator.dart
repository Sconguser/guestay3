import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/booking_confirmation/booking_confirmation_navigator.dart';
import 'package:guestay/payment_choice/payment_choice_navigator_cubit.dart';
import 'package:guestay/payment_choice/payment_choice_view.dart';
import 'package:guestay/room_list/room_list_navigator_cubit.dart';

import '../hotel_search/hotel_search_repository.dart';

class PaymentChoiceNavigator extends StatelessWidget {
  const PaymentChoiceNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return BlocProvider(
      create: (context) => PaymentChoiceNavigatorCubit(
          hotelSearchRepository: hotelSearchRepository),
      child:
          BlocBuilder<PaymentChoiceNavigatorCubit, PaymentChoiceNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: PaymentChoiceView()),
              if (state == PaymentChoiceNavigatorState.defaultView)
                MaterialPage(child: PaymentChoiceView()),
              if (state == PaymentChoiceNavigatorState.summaryView)
                MaterialPage(child: BookingConfirmationNavigator()),
            ],
            onPopPage: (route, result) {
              context.read<RoomListNavigatorCubit>().showDefaultView();
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
