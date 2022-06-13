import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/auth_credentials.dart';
import 'package:guestay/auth/auth_repository.dart';
import 'package:guestay/auth/form_submission_status.dart';

import '../auth_cubit.dart';
import '../user.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepository, required this.authCubit})
      : super(SignUpState()) {
    on<SignUpEmaiLChanged>(
        (event, emit) => emit(state.copyWith(userEmail: event.userEmail)));

    on<SignUpNameChanged>(
        (event, emit) => emit(state.copyWith(userName: event.userName)));
    on<SignUpLastNameChanged>((event, emit) =>
        emit(state.copyWith(userLastName: event.userLastName)));

    on<SignUpUsernameChanged>((event, emit) =>
        emit(state.copyWith(userUsername: event.userUsername)));

    on<SignUpPasswordChanged>((event, emit) =>
        emit(state.copyWith(userPassword: event.userPassword)));

    on<SignUpPasswordConfirmationChanged>((event, emit) => emit(state.copyWith(
        userPasswordConfirmation: event.userPasswordConfirmation)));

    on<SignUpSubmitted>((event, emit) async {
      emit(state.copyWith(formSubmissionStatus: FormSubmitting()));
      try {
        User user = await authRepository.signUp(
            email: state.userEmail,
            password: state.userPassword,
            passwordConfirmation: state.userPasswordConfirmation,
            name: state.userName,
            lastName: state.userLastName,
            username: state.userUsername);
        emit(state.copyWith(formSubmissionStatus: SubmissionSuccess()));
        authCubit.launchSession(AuthCredentials(user: user));
      } on Exception catch (_, e) {
        emit(state.copyWith(
            formSubmissionStatus: SubmissionFailed(exception: _)));
      }
    });
    on<GoogleSignUpSubmitted>((event, emit) async {
      emit(state.copyWith(formSubmissionStatus: FormSubmitting()));
      try {
        User user = await authRepository.signUp(
            email: event.email,
            password: event.password,
            passwordConfirmation: event.password,
            name: event.name,
            lastName: event.lastName,
            username: event.username);
        emit(state.copyWith(formSubmissionStatus: SubmissionSuccess()));
        authCubit.launchSession(AuthCredentials(user: user));
      } on Exception catch (_, e) {
        emit(state.copyWith(
            formSubmissionStatus: SubmissionFailed(exception: _)));
      }
    });
  }
}
