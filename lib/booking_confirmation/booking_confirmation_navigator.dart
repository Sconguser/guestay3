import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/booking_confirmation/booking_confirmation_navigator_cubit.dart';
import 'package:guestay/booking_confirmation/booking_confirmation_view.dart';
import 'package:guestay/congratulations/congratulations_navigator.dart';
import 'package:guestay/payment_choice/payment_choice_navigator_cubit.dart';

import '../hotel_search/hotel_search_repository.dart';

class BookingConfirmationNavigator extends StatelessWidget {
  const BookingConfirmationNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return BlocProvider(
      create: (context) => BookingConfirmationNavigatorCubit(
          hotelSearchRepository: hotelSearchRepository),
      child: BlocBuilder<BookingConfirmationNavigatorCubit,
          BookingConfirmationNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: BookingConfirmationView()),
              if (state == BookingConfirmationNavigatorState.defaultView)
                MaterialPage(child: BookingConfirmationView()),
              if (state ==
                  BookingConfirmationNavigatorState.congratulationsView)
                MaterialPage(child: CongratulationsNavigator()),
            ],
            onPopPage: (route, result) {
              context.read<PaymentChoiceNavigatorCubit>().showDefaultView();
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
