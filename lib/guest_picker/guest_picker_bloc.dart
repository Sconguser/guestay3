import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/guest_picker/guest_picker_event.dart';

import 'guest_picker_state.dart';

class GuestPickerBloc extends Bloc<GuestPickerEvent, GuestPickerState> {
  GuestPickerBloc() : super(GuestPickerState()) {
    on<AdultsNumberChanged>((event, emit) {
      if (event.adults >= 0) {
        emit(state.copyWith(adults: event.adults));
      }
    });
    on<ChildrenNumberChanged>((event, emit) {
      if (event.children >= 0) {
        emit(state.copyWith(children: event.children));
      }
    });
    on<InfantsNumberChanged>((event, emit) {
      if (event.infants >= 0) {
        emit(state.copyWith(infants: event.infants));
      }
    });
    on<PetsNumberChanged>((event, emit) {
      if (event.pets >= 0) {
        emit(state.copyWith(pets: event.pets));
      }
    });
  }
}
