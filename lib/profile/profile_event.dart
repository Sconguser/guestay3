abstract class ProfileEvent {}

class ChangeAvatarRequest extends ProfileEvent {}

class OpenImagePicker extends ProfileEvent {}

class ProvideImagePath extends ProfileEvent {
  final String avatarPath;

  ProvideImagePath({required this.avatarPath});
}

class ProfileDescriptionChanged extends ProfileEvent {
  final String userDescription;

  ProfileDescriptionChanged({required this.userDescription});
}

class SaveProfileChanges extends ProfileEvent {}

class SignOut extends ProfileEvent {}
