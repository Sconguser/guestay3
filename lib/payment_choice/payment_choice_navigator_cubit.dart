import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PaymentChoiceNavigatorState {
  defaultView,
  summaryView,
}

class PaymentChoiceNavigatorCubit extends Cubit<PaymentChoiceNavigatorState> {
  final HotelSearchRepository hotelSearchRepository;
  PaymentChoiceNavigatorCubit({required this.hotelSearchRepository})
      : super(PaymentChoiceNavigatorState.defaultView);

  void confirmChosenPaymentType(PaymentType? paymentType) {
    if (paymentType == null) {
      return;
    }
    hotelSearchRepository.setSelectedPaymentType(paymentType);
    showSummaryView();
  }

  void showDefaultView() => emit(PaymentChoiceNavigatorState.defaultView);

  void showSummaryView() => emit(PaymentChoiceNavigatorState.summaryView);
}
