import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/draft_reservations/user_draft_reservations_navigator.dart';
import 'package:guestay/home/home_navigator.dart';
import 'package:guestay/user_reservations/user_reservation_navigator.dart';

import '../home/home_view.dart';
import '../profile/provile_view.dart';
import 'bottom_nav_cubit.dart';

class BottomNavView extends StatelessWidget {
  const BottomNavView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BottomNavCubit(),
        child: BlocBuilder<BottomNavCubit, int>(builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state,
              children: [
                HomeNavigator(),
                UserReservationNavigator(),
                UserDraftReservationsNavigator(),
                ProfileView(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state,
              onTap: (index) => context.read<BottomNavCubit>().selectTab(index),
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_repair_service_rounded),
                    label: 'Reservations'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Drafts',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        }));
  }
}
