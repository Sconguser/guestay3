import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:guestay/shared/constants/colours.dart';

Widget defaultGuestaySpinner() {
  return Center(
    child: SpinKitSpinningLines(
      color: primaryColor,
      size: 70,
    ),
  );
}
