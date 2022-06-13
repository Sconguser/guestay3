import 'package:guestay/guest_picker/chosen_guests.dart';
import 'package:guestay/hotel_filters/hotel_filters.dart';

import '../models/offer.dart';
import '../models/room.dart';

enum PaymentType { CARD, CASH, UNKNOWN }

class HotelSearchRepository {
  String? destination;
  int? destinationId;

  DateTime? startDate;
  DateTime? endDate;

  ChosenGuests? chosenGuests;
  HotelFilters? hotelFilters;

  Offer? selectedHotel;
  // int? selectedHotelId;

  Room? selectedRoom;

  double? amountToBePaid;
  bool? isPaid;
  PaymentType? paymentType;

  void setChosenGuests(ChosenGuests chosenGuests) {
    this.chosenGuests = chosenGuests;
  }

  void setHotelFilters(HotelFilters hotelFilters) {
    this.hotelFilters = hotelFilters;
  }

  void setSelectedHotel(Offer selectedHotel) {
    this.selectedHotel = selectedHotel;
  }

  void setSelectedRoom(Room selectedRoom) {
    this.selectedRoom = selectedRoom;
  }

  void setSelectedPaymentType(PaymentType paymentType) {
    this.paymentType = paymentType;
  }

  static int paymentTypeToInt(PaymentType paymentType) {
    switch (paymentType) {
      case PaymentType.CARD:
        return 1;
      case PaymentType.CASH:
        return 2;
      default:
        return 0;
    }
  }

  static PaymentType intToPaymentType(int paymentType) {
    switch (paymentType) {
      case 1:
        return PaymentType.CARD;
      case 2:
        return PaymentType.CASH;
      default:
        return PaymentType.UNKNOWN;
    }
  }

  static String paymentTypeToString(PaymentType paymentType) {
    switch (paymentType) {
      case PaymentType.CARD:
        return 'card';
      case PaymentType.CASH:
        return 'cash';
      default:
        return 'unknown';
    }
  }

  static PaymentType stringToPaymentType(String paymentType) {
    switch (paymentType) {
      case 'card':
        return PaymentType.CARD;
      case 'cash':
        return PaymentType.CASH;
      default:
        return PaymentType.UNKNOWN;
    }
  }
}
