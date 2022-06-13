import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/auth_navigator.dart';
import 'package:guestay/session_cubit.dart';
import 'package:guestay/session_state.dart';
import 'package:guestay/views/session_view.dart';
import 'auth/auth_cubit.dart';
import 'bottom_nav/bottom_nav_view.dart';
import 'views/loading_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),
          if (state is Unauthenticated)
            MaterialPage(
                child: BlocProvider(
              create: (context) => AuthCubit(
                  sessionCubit: context.read<SessionCubit>()), //// dziwne
              child: AuthNavigator(),
            )),
          if (state is Authenticated) MaterialPage(child: BottomNavView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
