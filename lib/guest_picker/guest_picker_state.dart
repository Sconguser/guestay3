class GuestPickerState {
  int? adults;
  int? children;
  int? infants;
  int? pets;

  GuestPickerState({
    this.adults = 0,
    this.children = 0,
    this.infants = 0,
    this.pets = 0,
  });

  GuestPickerState copyWith(
      {int? adults, int? children, int? infants, int? pets}) {
    return GuestPickerState(
        adults: adults ?? this.adults,
        children: children ?? this.children,
        infants: infants ?? this.infants,
        pets: pets ?? this.pets);
  }
}
