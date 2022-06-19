import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/draft_reservations/user_draft_reservations_navigator_cubit.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/shared/divider.dart';

import '../auth/auth_repository.dart';
import '../booking_confirmation/draft_reservation_repository.dart';
import '../shared/spinner.dart';
import '../shared/utils.dart';
import 'draft_reservations_bloc.dart';
import 'draft_reservations_event.dart';
import 'draft_reservations_state.dart';

class UserDraftReservationsView extends StatelessWidget {
  const UserDraftReservationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => DraftReservationBloc(
            draftReservationRepository:
                context.read<DraftReservationRepository>())
          ..add(LoadDraftReservations(
              bearerToken: context.read<AuthRepository>().user.bearerToken!)),
        child: Container(
          decoration: backgroundDecoration,
          width: 1000,
          padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              containerAppBar(context, 'Your unfinished reservations', false),
              textFieldDivider,
              draftReservationList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget draftReservationList() {
    return BlocBuilder<DraftReservationBloc, DraftReservationsState>(
        builder: (context, state) {
      return state.isDraftReservationListLoading
          ? defaultGuestaySpinner()
          : SizedBox(height: 670, child: draftReservationBuilder());
    });
  }

  Widget draftReservationBuilder() {
    return BlocBuilder<DraftReservationBloc, DraftReservationsState>(
        builder: (context, state) {
      return ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: context
            .read<DraftReservationRepository>()
            .draftReservationList
            .length,
        itemBuilder: (BuildContext context, int index) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InkWell(
              onTap: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'You chose ${context.read<DraftReservationRepository>().draftReservationList.elementAt(index).roomName!}'),
                ));
                context
                    .read<UserDraftReservationsNavigatorCubit>()
                    .finishBooking(
                      context
                          .read<DraftReservationRepository>()
                          .draftReservationList
                          .elementAt(index)
                          .startDate!,
                      context
                          .read<DraftReservationRepository>()
                          .draftReservationList
                          .elementAt(index)
                          .endDate!,
                      context
                          .read<DraftReservationRepository>()
                          .draftReservationList
                          .elementAt(index)
                          .roomId!,
                    );
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(context
                                .read<DraftReservationRepository>()
                                .draftReservationList
                                .elementAt(index)
                                .roomName!),
                            Text(parseDates(
                                context
                                    .read<DraftReservationRepository>()
                                    .draftReservationList
                                    .elementAt(index)
                                    .startDate!,
                                context
                                    .read<DraftReservationRepository>()
                                    .draftReservationList
                                    .elementAt(index)
                                    .endDate!)),
                            Text(
                                '${context.read<DraftReservationRepository>().draftReservationList.elementAt(index).finalPrice} zł'),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                          width: 130,
                          child: Image.asset(
                              'assets/images/${context.read<DraftReservationRepository>().draftReservationList.elementAt(index).roomName!.toLowerCase()}.jpg'),
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
