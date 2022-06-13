import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/home/home_navigator_cubit.dart';
import 'package:guestay/shared/constants/background.dart';

import '../auth/auth_repository.dart';
import '../auth/user.dart';
import '../shared/constants/colours.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CongratulationView extends StatelessWidget {
  const CongratulationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        width: 1000,
        padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
        child: Column(
          children: [
            peopleImage(context),
            SizedBox(
              height: 20,
            ),
            congratulationsText(context),
            SizedBox(height: 380),
            homeButton(context),
          ],
        ),
      ),
    );
  }

  Widget peopleImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset('assets/images/6583.jpg'),
    );
  }

  Widget congratulationsText(BuildContext context) {
    AuthRepository authRepository = context.read<AuthRepository>();
    User user = authRepository.user;
    return Column(
      children: [
        Text(
          'Congratulations ${user.name}!',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Your booking has been confirmed',
          style: TextStyle(
            fontSize: 15,
          ),
        )
      ],
    );
  }

  Widget homeButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 50,
        width: 350,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: primaryColor, elevation: 0),
          onPressed: () {
            _homeButtonPressed(context);
          },
          child: Text(
            'Go back home',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  void _homeButtonPressed(BuildContext context) {
    context.read<HomeNavigatorCubit>().showHome();
  }
}
