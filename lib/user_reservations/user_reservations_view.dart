import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/shared/divider.dart';
import 'package:guestay/shared/utils.dart';
import 'package:guestay/user_reservations/reservation_bloc.dart';
import 'package:guestay/user_reservations/reservation_event.dart';
import 'package:guestay/user_reservations/reservation_repository.dart';
import 'package:guestay/user_reservations/reservation_state.dart';

import '../auth/auth_repository.dart';
import '../shared/spinner.dart';

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
          padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              containerAppBar(context, 'Your reservations', false),
              textFieldDivider,
              reservationList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget reservationList() {
    return BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
      return state.isReservationListLoading
          ? defaultGuestaySpinner()
          : SizedBox(height: 670, child: reservationBuilder());
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(context
                                .read<ReservationRepository>()
                                .reservationList
                                .elementAt(index)
                                .roomName!),
                            Text(
                              '${parseDates(context.read<ReservationRepository>().reservationList.elementAt(index).startDate!, context.read<ReservationRepository>().reservationList.elementAt(index).endDate!)}',
                            ),
                            Text(
                                '${context.read<ReservationRepository>().reservationList.elementAt(index).finalPrice.toString()}zł'),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                          width: 130,
                          child: Image.asset(
                              'assets/images/${context.read<ReservationRepository>().reservationList.elementAt(index).roomName!.toLowerCase()}.jpg'),
                        )
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
