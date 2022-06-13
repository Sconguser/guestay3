import '../models/city.dart';

class HomeState {
  List<City>? cities;
  bool isCityListLoading = true;
  // HomeState({
  //   required List<City> cities,
  // }) : this.cities = cities;
  HomeState({
    List<City>? cities,
    required bool isCityListLoading,
  })  : this.cities = cities,
        this.isCityListLoading = isCityListLoading;

  HomeState copyWith({List<City>? cities, required bool isCityListLoading}) {
    return HomeState(
      cities: cities ?? this.cities,
      isCityListLoading: isCityListLoading,
    );
  }
}
