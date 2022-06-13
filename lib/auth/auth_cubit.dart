import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/auth_credentials.dart';
import 'package:guestay/auth/user.dart';
import 'package:guestay/session_cubit.dart';

enum AuthState { login, signUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  AuthCredentials? credentials;

  void showLogin({required User user}) {
    credentials = AuthCredentials(user: user);
    emit(AuthState.login);
  }

  void showSignUp({required User user}) {
    credentials = AuthCredentials(user: user);
    emit(AuthState.signUp);
  }

  void launchSession(AuthCredentials credentials) {
    sessionCubit.showSession(credentials);
  }
}
