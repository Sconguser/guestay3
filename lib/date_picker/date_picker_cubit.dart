import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';

enum DatePickerState { open, closed, cancelling, confirming }

class DatePickerCubit extends Cubit<DatePickerState> {
  DatePickerCubit({required this.hotelSearchRepository})
      : super(DatePickerState.closed);

  final HotelSearchRepository? hotelSearchRepository;

  void confirmChosenDates(DateTime startDate, DateTime endDate) {
    hotelSearchRepository?.startDate = startDate;
    hotelSearchRepository?.endDate = endDate;
    emit(DatePickerState.confirming);
  }

  void cancelDatePicker() => emit(DatePickerState.cancelling);
}
