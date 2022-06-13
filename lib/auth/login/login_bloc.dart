import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/auth_credentials.dart';
import 'package:guestay/auth/auth_repository.dart';
import 'package:guestay/auth/form_submission_status.dart';
import 'package:guestay/home/home_list_repository.dart';
import 'package:guestay/session_state.dart';

import '../auth_cubit.dart';
import '../user.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;
  final HomeListRepository homeListRepository;
  LoginBloc({
    required this.authRepository,
    required this.authCubit,
    required this.homeListRepository,
  }) : super(LoginState()) {
    on<LoginUserEmailChanged>(
        (event, emit) => emit(state.copyWith(userEmail: event.userEmail)));
    on<LoginPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formSubmissionStatus: FormSubmitting()));
      try {
        User user = await authRepository.login(
            email: state.userEmail, password: state.password);
        // await homeListRepository.getCities();
        emit(state.copyWith(formSubmissionStatus: SubmissionSuccess()));
        authCubit.launchSession(AuthCredentials(user: user));
      } on Exception catch (_, e) {
        emit(state.copyWith(
            formSubmissionStatus: SubmissionFailed(exception: _)));
      }
    });

    on<GoogleLoginSubmitted>((event, emit) async {
      emit(state.copyWith(formSubmissionStatus: FormSubmitting()));
      try {
        User user = await authRepository.login(
            email: event.email, password: event.password);
        // await homeListRepository.getCities();
        emit(state.copyWith(formSubmissionStatus: SubmissionSuccess()));
        authCubit.launchSession(AuthCredentials(user: user));
      } on Exception catch (_, e) {
        emit(state.copyWith(
            formSubmissionStatus: SubmissionFailed(exception: _)));
      }
    });
  }

  // @override
  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   if (event is LoginUsernameChanged) {
  //     yield state.copyWith(userEmail: event.userEmail);
  //   } else if (event is LoginPasswordChanged) {
  //     yield state.copyWith(password: event.password);
  //   } else if (event is LoginSubmitted) {
  //     yield state.copyWith(formSubmissionStatus: FormSubmitting());
  //     try {
  //       await authRepository.login();
  //       yield state.copyWith(formSubmissionStatus: SubmissionSuccess());
  //     } on Exception catch (_, e) {
  //       yield state.copyWith(
  //           formSubmissionStatus: SubmissionFailed(exception: _));
  //     }
  //   }
  // }
}
