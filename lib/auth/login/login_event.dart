abstract class LoginEvent {}

class LoginUserEmailChanged extends LoginEvent {
  final String userEmail;

  LoginUserEmailChanged({required this.userEmail});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}

class GoogleLoginSubmitted extends LoginEvent {
  String email;
  String password;

  GoogleLoginSubmitted({required this.email, required this.password});
}
