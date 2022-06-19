import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/city.dart';
import '../models/offer.dart';
import 'hotel_list_event.dart';
import 'hotel_list_repository.dart';
import 'hotel_list_state.dart';

class HotelListBloc extends Bloc<HotelListEvent, HotelListState> {
  final HotelListRepository hotelListRepository;
  HotelListBloc({
    required this.hotelListRepository,
  }) : super(HotelListState(
          isOfferListLoading: true,
        )) {
    on<LoadOfferList>((event, emit) async {
      emit(
        state.copyWith(isOfferListLoading: true),
      );
      try {
        List<Offer> offers = await hotelListRepository.getOffersForCity(
            event.cityId, event.startDate, event.endDate, event.maxPrice);
        emit(state.copyWith(offers: offers, isOfferListLoading: false));
      } catch (e) {
        print('NIE UDALO SIE ZALADOWAC LISTY HOTELI $e');
      }
    });
  }
}
