import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/payment_choice/payment_choice_navigator_cubit.dart';
import 'package:guestay/shared/constants/background.dart';

import '../hotel_search/hotel_search_repository.dart';
import '../shared/constants/colours.dart';

class PaymentChoiceView extends StatelessWidget {
  const PaymentChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: Container(
        width: 1000,
        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
        decoration: backgroundDecoration,
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: cardButton(context),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 100,
              child: paymentAtHotelButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _paymentButtonPressed(context, PaymentType.CARD);
      },
      child: SizedBox(
        height: 150,
        width: 700,
        child: Card(
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 90,
                  height: 80,
                  color: Colors.white,
                  child: Icon(
                    Icons.credit_card,
                    size: 60,
                  ),
                ),
              ),
              // SizedBox(
              //   width: 20,
              // ),
              Text(
                'Debit/Credit card',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget paymentAtHotelButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _paymentButtonPressed(context, PaymentType.CASH);
      },
      child: SizedBox(
        height: 150,
        width: 700,
        child: Card(
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 90,
                  height: 80,
                  color: Colors.white,
                  child: Icon(
                    Icons.attach_money,
                    size: 60,
                  ),
                ),
              ),
              // SizedBox(
              //   width: 20,
              // ),
              Text(
                'Pay at the hotel',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  void _paymentButtonPressed(BuildContext context, PaymentType paymentType) {
    context
        .read<PaymentChoiceNavigatorCubit>()
        .confirmChosenPaymentType(paymentType);
  }
}
