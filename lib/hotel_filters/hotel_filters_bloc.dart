import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_filters/hotel_filters_event.dart';
import 'package:guestay/hotel_filters/hotel_filters_state.dart';

class HotelFiltersBloc extends Bloc<HotelFiltersEvent, HotelFiltersState> {
  HotelFiltersBloc() : super(HotelFiltersState()) {
    on<WifiChanged>((event, emit) {
      emit(state.copyWith(wifi: event.wifi));
    });

    on<FreeParkingChanged>((event, emit) {
      emit(state.copyWith(freeParking: event.freeParking));
    });

    on<FreeCancellationChanged>((event, emit) {
      emit(state.copyWith(freeCancellation: event.freeCancellation));
    });

    on<KitchenChanged>((event, emit) {
      emit(state.copyWith(kitchen: event.kitchen));
    });

    on<WashingMachineChanged>((event, emit) {
      emit(state.copyWith(washingMachine: event.washingMachine));
    });

    on<BreakfastChanged>((event, emit) {
      emit(state.copyWith(breakfast: event.breakfast));
    });

    on<EntirePlaceChanged>((event, emit) {
      emit(state.copyWith(entirePlace: event.entirePlace));
    });

    on<PrivateRoomChanged>((event, emit) {
      emit(state.copyWith(privateRoom: event.privateRoom));
    });

    on<SharedRoomChanged>((event, emit) {
      emit(state.copyWith(sharedRoom: event.sharedRoom));
    });

    on<HotelRoomChanged>((event, emit) {
      emit(state.copyWith(hotelRoom: event.hotelRoom));
    });

    on<MinPriceChanged>((event, emit) {
      emit(state.copyWith(minPrice: event.minPrice));
    });

    on<MaxPriceChanged>((event, emit) {
      emit(state.copyWith(maxPrice: event.maxPrice));
    });
  }
}
