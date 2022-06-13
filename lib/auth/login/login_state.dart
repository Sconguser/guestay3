import 'package:guestay/auth/form_submission_status.dart';
import 'package:guestay/auth/utils/validators.dart';

class LoginState {
  final String userEmail;
  // bool get isValidUsername => userEmail.length > 6 && userEmail.contains('@');
  bool get isValidUserEmail => userEmailValidate(userEmail);
  final String password;
  bool get isValidPassword => userPasswordValidate(password);
  final FormSubmissionStatus? formSubmissionStatus;

  LoginState({
    this.userEmail = '',
    this.password = '',
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? userEmail,
    String? password,
    FormSubmissionStatus? formSubmissionStatus,
  }) {
    return LoginState(
      userEmail: userEmail ?? this.userEmail,
      password: password ?? this.password,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }
}
