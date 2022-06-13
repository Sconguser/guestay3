import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/profile/profile_event.dart';
import 'package:guestay/profile/profile_state.dart';
import 'package:guestay/session_cubit.dart';

import '../auth/auth_cubit.dart';
import '../auth/user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late SessionCubit sessionCubit;
  ProfileBloc({
    required SessionCubit sessionCubit,
    required User user,
    required bool isCurrentUser,
  }) : super(ProfileState(
            user: user,
            isCurrentUser: isCurrentUser,
            sessionCubit: sessionCubit)) {
    on<ProvideImagePath>(
        (event, emit) => emit(state.copyWith(avatarPath: event.avatarPath)));
    on<ChangeAvatarRequest>((event, emit) => null);
    on<OpenImagePicker>((event, emit) => null);
    on<ProfileDescriptionChanged>((event, emit) =>
        emit(state.copyWith(userDescription: event.userDescription)));
    on<SaveProfileChanges>((event, emit) => null);
    on<SignOut>((event, emit) => sessionCubit.signOut());
  }
}
