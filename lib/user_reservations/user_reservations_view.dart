import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/user_reservations/reservation_bloc.dart';
import 'package:guestay/user_reservations/reservation_event.dart';
import 'package:guestay/user_reservations/reservation_repository.dart';
import 'package:guestay/user_reservations/reservation_state.dart';

import '../auth/auth_repository.dart';

class UserReservationsView extends StatelessWidget {
  const UserReservationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ReservationBloc(
            reservationRepository: context.read<ReservationRepository>())
          ..add(LoadUserReservation(
              bearerToken: context.read<AuthRepository>().user.bearerToken!)),
        child: Container(
          decoration: backgroundDecoration,
          width: 1000,
          padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reservationList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget reservationList() {
    return BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
      return state.isReservationListLoading
          ? CircularProgressIndicator()
          : SizedBox(height: 490, child: reservationBuilder());
    });
  }

  Widget reservationBuilder() {
    return BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
      return ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: context.read<ReservationRepository>().reservationList.length,
        itemBuilder: (BuildContext context, int index) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InkWell(
              onTap: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'You chose ${context.read<ReservationRepository>().reservationList.elementAt(index).roomName!}'),
                ));
                // context.read<RoomListNavigatorCubit>().confirmSelectedRoom(
                //     context
                //         .read<RoomListRepository>()
                //         .roomsList
                //         .elementAt(index));
              },
              child: SizedBox(
                height: 100,
                child: Card(
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(context
                            .read<ReservationRepository>()
                            .reservationList
                            .elementAt(index)
                            .roomName!),
                      ],
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
}
