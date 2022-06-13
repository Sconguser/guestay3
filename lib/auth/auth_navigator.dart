import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/auth_cubit.dart';
import 'package:guestay/auth/sign_up/views/sign_up_view.dart';

import 'login/views/login_view.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state == AuthState.login) MaterialPage(child: LoginView()),
          if (state == AuthState.signUp) MaterialPage(child: SignUpView()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
