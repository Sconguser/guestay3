import '../models/city.dart';
import '../models/offer.dart';

class HotelListState {
  List<Offer>? offers;
  bool isOfferListLoading = true;
  // HomeState({
  //   required List<City> cities,
  // }) : this.cities = cities;
  HotelListState({
    List<Offer>? offers,
    required bool isOfferListLoading,
  })  : this.offers = offers,
        this.isOfferListLoading = isOfferListLoading;

  HotelListState copyWith(
      {List<Offer>? offers, required bool isOfferListLoading}) {
    return HotelListState(
      offers: offers ?? this.offers,
      isOfferListLoading: isOfferListLoading,
    );
  }
}
