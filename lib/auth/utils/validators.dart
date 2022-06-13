// String? inputValidator(String? value, String errorMessage) {
//   if (value == null || value.isEmpty) {
//     return errorMessage;
//   }
//   return null;
// }
//
// String? passwordValidator(String? value, int requiredLength) {
//   if (value == null || value.length < requiredLength) {
//     return 'Enter password at least $requiredLength characters long';
//   }
//   return null;
// }
//
// String? passwordConfirmationValidator(
//     String? value, String? value2, int requiredLength) {
//   if (value == null || value.length < requiredLength) {
//     return 'Enter password at least $requiredLength characters long';
//   }
//   if (value != value2) {
//     return 'Passwords do not match';
//   }
//   return null;
// }

bool userEmailValidate(String userEmail) {
  return userEmail.length >= 6 && userEmail.contains('@');
}

bool userPasswordValidate(String password) {
  return password.length >= 6;
}

bool userUsernameValidate(String username) {
  return username.length >= 6;
}

bool userPasswordConfirmationValidate(String password1, String password2) {
  return password1.length >= 6 &&
      password2.length >= 6 &&
      password1 == password2;
}
