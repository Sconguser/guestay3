import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/city.dart';
import 'home_event.dart';
import 'home_list_repository.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeListRepository homeListRepository;
  HomeBloc({
    required this.homeListRepository,
  }) : super(HomeState(isCityListLoading: true)) {
    on<LoadCitiesList>((event, emit) async {
      emit(state.copyWith(isCityListLoading: true));
      try {
        List<City> cities = await homeListRepository.getCities();
        emit(state.copyWith(cities: cities, isCityListLoading: false));
      } catch (e) {
        print('NIE UDALO SIE ZALADOWAC LISTY MIAST $e');
      }
    });
  }
}
