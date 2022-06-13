import 'package:flutter/cupertino.dart';
import 'package:guestay/auth/form_submission_status.dart';
import 'package:guestay/session_cubit.dart';

import '../auth/user.dart';

class ProfileState {
  final User user;
  final bool isCurrentUser;
  final String? avatarPath;
  final String? userDescription;
  final SessionCubit sessionCubit;
  String? get username => user.username;

  String? get email => user.email;

  final FormSubmissionStatus formSubmissionStatus;

  ProfileState({
    required User user,
    required bool isCurrentUser,
    String? avatarPath,
    String? userDescription,
    required SessionCubit sessionCubit,
    this.formSubmissionStatus = const InitialFormStatus(),
  })  : this.user = user,
        this.isCurrentUser = isCurrentUser,
        this.avatarPath = avatarPath,
        this.userDescription = userDescription ?? user.name,
        this.sessionCubit = sessionCubit;

  ProfileState copyWith({
    User? user,
    String? avatarPath,
    String? userDescription,
    FormSubmissionStatus? formSubmissionStatus,
    SessionCubit? sessionCubit,
  }) {
    return ProfileState(
        sessionCubit: sessionCubit ?? this.sessionCubit,
        user: user ?? this.user,
        isCurrentUser: this.isCurrentUser,
        avatarPath: avatarPath ?? this.avatarPath,
        formSubmissionStatus:
            formSubmissionStatus ?? this.formSubmissionStatus);
  }
}
