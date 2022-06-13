abstract class GuestPickerEvent {}

class AdultsNumberChanged extends GuestPickerEvent {
  final int adults;
  AdultsNumberChanged({required this.adults});
}

class ChildrenNumberChanged extends GuestPickerEvent {
  final int children;
  ChildrenNumberChanged({required this.children});
}

class InfantsNumberChanged extends GuestPickerEvent {
  final int infants;
  InfantsNumberChanged({required this.infants});
}

class PetsNumberChanged extends GuestPickerEvent {
  final int pets;
  PetsNumberChanged({required this.pets});
}

class GuestNumberSubmitted extends GuestPickerEvent {}
