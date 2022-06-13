import '../hotel_search/hotel_search_repository.dart';

String formatDate(HotelSearchRepository hotelSearchRepository) {
  if (hotelSearchRepository == null ||
      hotelSearchRepository.startDate == null ||
      hotelSearchRepository.endDate == null) {
    return 'No dates were chosen';
  }

  return '${hotelSearchRepository.startDate?.day} ${formatMonthNumberToString(hotelSearchRepository.startDate?.month)}'
      ' - ${hotelSearchRepository.endDate?.day} ${formatMonthNumberToString(hotelSearchRepository.endDate?.month)}';
}

String formatMonthNumberToString(int? number) {
  switch (number) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return 'Error';
  }
}

int guestNumber(HotelSearchRepository hotelSearchRepository) {
  if (hotelSearchRepository == null) return -1;
  int adults = hotelSearchRepository.chosenGuests?.adults ?? 0;
  int children = hotelSearchRepository.chosenGuests?.children ?? 0;
  int pets = hotelSearchRepository.chosenGuests?.pets ?? 0;
  int infants = hotelSearchRepository.chosenGuests?.infants ?? 0;

  return adults + children + pets + infants;
}

String formatGuestNumber(HotelSearchRepository hotelSearchRepository) {
  int number = guestNumber(hotelSearchRepository);
  if (number > 1) return '$number guests';
  return '1 guest';
}
