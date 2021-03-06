import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/auth_repository.dart';
import 'package:guestay/booking_confirmation/booking_confirmation_event.dart';
import 'package:guestay/booking_confirmation/booking_confirmation_navigator_cubit.dart';
import 'package:guestay/booking_confirmation/draft_reservation_repository.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/shared/divider.dart';
import 'package:guestay/user_reservations/reservation_repository.dart';

import '../shared/constants/colours.dart';
import '../shared/spinner.dart';
import '../shared/utils.dart';
import 'booking_confirmation_bloc.dart';
import 'booking_confirmation_state.dart';

class BookingConfirmationView extends StatelessWidget {
  const BookingConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black54,
      //     ),
      //   ),
      // ),
      body: BlocProvider(
        create: (context) => BookingConfirmationBloc(
          draftReservationRepository:
              context.read<DraftReservationRepository>(),
          authRepository: context.read<AuthRepository>(),
          hotelSearchRepository: context.read<HotelSearchRepository>(),
        )..add(CreateDraftReservation(
            startDate: context.read<DraftReservationRepository>().startDate!,
            endDate: context.read<DraftReservationRepository>().endDate!,
            id: context.read<DraftReservationRepository>().roomId!,
          )),
        child: Container(
          width: 1000,
          decoration: backgroundDecoration,
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            children: [
              containerAppBar(context, 'Booking summary', true),
              textFieldDivider,
              // chosenRoomTile(context),
              // chosenDatesTile(context),
              // paymentSummaryTile(context),
              // paymentTypeTile(context),
              bookingConfirmationTile(),
              SizedBox(
                height: 5,
              ),
              confirmBookingButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookingConfirmationTile() {
    return BlocBuilder<BookingConfirmationBloc, BookingConfirmationState>(
        builder: (context, state) {
      return state.isDraftBeingCreated
          ? defaultGuestaySpinner()
          : Column(
              children: [
                chosenRoomTile(state),
                chosenDatesTile(context, state),
                paymentSummaryTile(context, state),
                paymentTypeTile(context),
              ],
            );
    });
  }

  Widget chosenRoomTile(BookingConfirmationState state) {
    return Card(
      color: primaryColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(5),
          // color: gradientPrimaryColor,
          width: 370,
          height: 150,
          child: Center(
              child: Row(
            children: [
              Column(
                children: [
                  SizedBox(height: 15),
                  Text(
                    state.hotelSearchRepository.selectedRoom!.roomAttributes!
                        .name!,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text('${state.draftReservation!.pricePerDay} z??',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Text(
                    'Price per night',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 210,
                    child: Image.asset(
                        'assets/images/${state.hotelSearchRepository.selectedRoom!.roomAttributes!.name!.toLowerCase()}.jpg'),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget chosenDatesTile(BuildContext context, BookingConfirmationState state) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return Card(
      color: primaryColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(5),
          width: 370,
          height: 100,
          child: Column(
            children: [
              Text(
                'Check in - Check out',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30),
              Text(
                parseDates(state.draftReservation!.startDate!,
                    state.draftReservation!.endDate!),
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentSummaryTile(
      BuildContext context, BookingConfirmationState state) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return Card(
      color: primaryColor,
      child: Container(
        width: 370,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${state.draftReservation!.numberOfDays} nights',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${state.draftReservation!.numberOfDays! * state.draftReservation!.pricePerDay!} z??',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '+ Services (taxes & fees)',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                textFieldDivider,
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${state.draftReservation!.finalPrice} z??',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentTypeTile(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    bool isCard =
        hotelSearchRepository.paymentType == PaymentType.CARD ? true : false;
    return Card(
      color: primaryColor,
      child: Container(
        width: 370,
        child: Row(
          children: [
            Icon(
              isCard ? Icons.credit_card : Icons.attach_money,
              size: 60,
            ),
            SizedBox(width: 30),
            Text(isCard ? 'Debit/Credit card' : 'Pay at the hotel',
                style: TextStyle(
                  fontSize: 20,
                )),
          ],
        ),
      ),
    );
  }

  Widget confirmBookingButton() {
    return BlocBuilder<BookingConfirmationBloc, BookingConfirmationState>(
        builder: (context, state) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 370,
          height: 50,
          child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: primaryColor, elevation: 0),
              onPressed: () {
                _confirmBookingButtonPressed(context, state);
              },
              child: Text(
                'Book now',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              )),
        ),
      );
    });
  }

  void _confirmBookingButtonPressed(
      BuildContext context, BookingConfirmationState state) async {
    BookingConfirmationNavigatorCubit _cubit =
        context.read<BookingConfirmationNavigatorCubit>();
    // _cubit.confirmBooking();
    await context.read<ReservationRepository>().createReservation(
        state.draftReservation!.id!,
        HotelSearchRepository.paymentTypeToString(
            state.hotelSearchRepository.paymentType!),
        state.draftReservation!.finalPrice!.round(),
        context.read<AuthRepository>().user.bearerToken!);
    _cubit.showCongratulations();
    context
        .read<ReservationRepository>()
        .getUserReservations(context.read<AuthRepository>().user.bearerToken!);
  }

  // String parseDates(DateTime startDate, DateTime endDate) {
  //   return '${startDate.day} ${formatMonthNumberToString(startDate.month)} - ${endDate.day} ${formatMonthNumberToString(endDate.month)}';
  // }
}
