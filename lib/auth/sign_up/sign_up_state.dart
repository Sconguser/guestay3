import 'package:guestay/auth/form_submission_status.dart';
import 'package:guestay/auth/utils/validators.dart';

class SignUpState {
  final String userUsername;

  bool get isValidUsername => userUsernameValidate(userUsername);
  final String userEmail;

  bool get isValidUserEmail => userEmailValidate(userEmail);
  final String userPassword;

  bool get isValidPassword => userPasswordValidate(userPassword);
  final String userPasswordConfirmation;

  bool get isValidPasswordConfirmation =>
      userPasswordConfirmationValidate(userPassword, userPasswordConfirmation);
  final String userName;
  final String userLastName;
  final FormSubmissionStatus formSubmissionStatus;

  SignUpState({
    this.userUsername = '',
    this.userEmail = '',
    this.userPassword = '',
    this.userPasswordConfirmation = '',
    this.userName = '',
    this.userLastName = '',
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  SignUpState copyWith({
    String? userUsername,
    String? userPassword,
    String? userPasswordConfirmation,
    String? userEmail,
    String? userName,
    String? userLastName,
    FormSubmissionStatus? formSubmissionStatus,
  }) {
    return SignUpState(
        userUsername: userUsername ?? this.userUsername,
        userPassword: userPassword ?? this.userPassword,
        userPasswordConfirmation:
            userPasswordConfirmation ?? this.userPasswordConfirmation,
        userEmail: userEmail ?? this.userEmail,
        userName: userName ?? this.userName,
        userLastName: userLastName ?? this.userLastName,
        formSubmissionStatus:
            formSubmissionStatus ?? this.formSubmissionStatus);
  }
}
