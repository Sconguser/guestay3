import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/home/home_navigator_cubit.dart';
import 'package:guestay/hotel_search/hotel_search_navigator.dart';

import '../hotel_search/hotel_search_view.dart';
import '../profile/provile_view.dart';
import 'home_view.dart';

class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavigatorCubit(),
      child: BlocBuilder<HomeNavigatorCubit, HomeNavigatorState>(
          builder: (context, state) {
        return Navigator(
          pages: [
            MaterialPage(child: (HomeView())),
            if (state == HomeNavigatorState.profile)
              MaterialPage(child: ProfileView()),
            if (state == HomeNavigatorState.hotelSearch)
              MaterialPage(child: HotelSearchNavigator()),
            if (state == HomeNavigatorState.home)
              MaterialPage(child: HomeView()),
          ],
          onPopPage: (route, result) {
            context.read<HomeNavigatorCubit>().showHome();
            return route.didPop(result);
          },
        );
      }),
    );
  }
}
