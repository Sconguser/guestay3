import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/auth_repository.dart';
import 'package:guestay/booking_confirmation/draft_reservation_repository.dart';
import 'package:guestay/home/home_list_repository.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/room_list/room_list_repository.dart';
import 'package:guestay/session_cubit.dart';
import 'package:guestay/user_reservations/reservation_repository.dart';

import 'app_navigator.dart';

import 'hotel_list/hotel_list_repository.dart';
import 'shared/constants/decorations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Guestay',
        theme: mainThemeData,
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => AuthRepository()),
            RepositoryProvider(create: (context) => HotelSearchRepository()),
            RepositoryProvider(create: (context) => RoomListRepository()),
            RepositoryProvider(create: (context) => HomeListRepository()),
            RepositoryProvider(create: (context) => HotelListRepository()),
            RepositoryProvider(
                create: (context) => DraftReservationRepository()),
            RepositoryProvider(create: (context) => ReservationRepository()),
          ],
          child: BlocProvider(
            create: (context) =>
                SessionCubit(authRepository: context.read<AuthRepository>()),
            child: const AppNavigator(),
          ),
        ),
      ),
    );
  }
}
