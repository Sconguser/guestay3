import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/congratulations/congratulations_navigator_cubit.dart';
import 'package:guestay/congratulations/congratulations_view.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';

class CongratulationsNavigator extends StatelessWidget {
  const CongratulationsNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return BlocProvider(
      create: (context) => CongratulationsNavigatorCubit(
          hotelSearchRepository: hotelSearchRepository),
      child: BlocBuilder<CongratulationsNavigatorCubit,
          CongratulationsNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: CongratulationView()),
              if (state == CongratulationsNavigatorState.defaultView)
                MaterialPage(child: CongratulationView()),
            ],
            onPopPage: (route, result) {
              // context.read<HotelSearchNavigatorCubit>().showDefaultView();
              context.read<CongratulationsNavigatorCubit>().showDefaultView();
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
