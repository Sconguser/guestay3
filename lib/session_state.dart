import 'auth/user.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  User user = User();
  User? selectedUser;
  Authenticated({required this.user});
}
