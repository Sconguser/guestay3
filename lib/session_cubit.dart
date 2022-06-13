import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/auth_repository.dart';
import 'package:guestay/session_state.dart';

import 'auth/auth_credentials.dart';
import 'auth/user.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepository;

  User get currentUser => (state as Authenticated).user;
  User? get selectedUser => (state as Authenticated).selectedUser;
  bool get isCurrentUserSelected =>
      selectedUser == null || currentUser.id == selectedUser?.id;

  SessionCubit({required this.authRepository}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void showAuth() => emit(Unauthenticated());
  void attemptAutoLogin() async {
    try {
      await authRepository.attemptAutoLogin();
      emit(Authenticated(user: authRepository.user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showSession(AuthCredentials credentials) {
    emit(Authenticated(user: credentials.user));
  }

  void signOut() {
    authRepository.signOut();
    emit(Unauthenticated());
  }
}
