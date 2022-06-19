import 'package:flutter/material.dart';

import '../shared/spinner.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: defaultGuestaySpinner());
  }
}
