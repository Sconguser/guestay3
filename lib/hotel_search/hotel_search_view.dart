import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:guestay/home/home_navigator_cubit.dart';
import 'package:guestay/hotel_search/hotel_search_navigator.dart';
import 'package:guestay/hotel_search/hotel_search_navigator_cubit.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/shared/divider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../hotel_filters/hotel_filters.dart';
import '../shared/constants/colours.dart';

class HotelSearchView extends StatelessWidget {
  const HotelSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: backgroundDecoration,
        child: Column(
          children: [
            containerAppBar(context, 'Hotel search', true),
            textFieldDivider,
            SizedBox(height: 20),
            _cityName(hotelSearchRepository.destination, context),
            SizedBox(height: 20),
            _datePickerButton(context),
            SizedBox(height: 20),
            _guestsPickerButton(context),
            SizedBox(height: 20),
            _pickedDates(context),
            SizedBox(height: 20),
            _pickedGuests(context),
            // SizedBox(height: 100),
            // _debugButton(context),
            SizedBox(height: 20),
            _hotelViewButton(context),
          ],
        ),
      ),
    );
    // return DatePickerDialog(
    //     initialDate: DateTime.now(), firstDate: D, lastDate: DateTime.now());
  }

  Widget _cityName(String? cityName, BuildContext context) {
    cityName ??= 'Where to?';
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // padding: EdgeInsets.fromLTRB(0, 20, 0, bottom),
        width: 400,
        height: 50,
        color: primaryColor,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                context.read<HomeNavigatorCubit>().showHome();
              },
              // alignment: ,
            ),
            SizedBox(width: 90),
            Text(
              cityName,
              style: TextStyle(height: 2, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _datePickerButton(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 400,
        height: 50,
        child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(primary: primaryColor, elevation: 0),
            onPressed: () {
              _datePickerButtonPressed(context);
            },
            child: Text(
              'Check-In and Check-out',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  void _datePickerButtonPressed(BuildContext context) {
    context.read<HotelSearchNavigatorCubit>().showDatePicker();
  }

  Widget _guestsPickerButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 400,
        height: 50,
        child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(primary: primaryColor, elevation: 0),
            onPressed: () {
              _guestPickerButtonPressed(context);
            },
            child: Text(
              'Guests',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  void _guestPickerButtonPressed(BuildContext context) {
    context.read<HotelSearchNavigatorCubit>().showGuestPicker();
  }

  Widget _debugButton(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 400,
        height: 50,
        child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(primary: primaryColor, elevation: 0),
            onPressed: () {
              print(hotelSearchRepository.startDate);
              print(hotelSearchRepository.endDate);
              print(hotelSearchRepository.chosenGuests?.adults);
            },
            child: Text(
              'Debug',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  Widget _pickedDates(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    if (hotelSearchRepository.startDate != null) {
      return Visibility(
        visible: hotelSearchRepository.startDate != null,
        child: Row(
          children: [
            Text(hotelSearchRepository.startDate!.day.toString()),
            SizedBox(width: 10),
            Text(hotelSearchRepository.endDate!.day.toString())
          ],
        ),
      );
    } else {
      return SizedBox(height: 0);
    }
  }

  Widget _hotelViewButton(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 400,
        height: 50,
        child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(primary: primaryColor, elevation: 0),
            onPressed: () {
              _hotelViewButtonPressed(context);
            },
            child: Text(
              'Search',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  void _hotelViewButtonPressed(BuildContext context) {
    context.read<HotelSearchNavigatorCubit>().showHotelListView();
  }

  Widget _pickedGuests(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    if (hotelSearchRepository.chosenGuests?.adults != null &&
        hotelSearchRepository.chosenGuests?.children != null &&
        hotelSearchRepository.chosenGuests?.infants != null &&
        hotelSearchRepository.chosenGuests?.pets != null) {
      return Visibility(
        visible: true,
        child: Column(
          children: [
            Text(
                'Adults: ${hotelSearchRepository.chosenGuests?.adults.toString()}'),
            Text(
                'Children: ${hotelSearchRepository.chosenGuests?.children.toString()}'),
            Text(
                'Infants: ${hotelSearchRepository.chosenGuests?.infants.toString()}'),
            Text(
                'Pets: ${hotelSearchRepository.chosenGuests?.pets.toString()}'),
          ],
        ),
      );
    } else {
      return SizedBox(height: 1);
    }
  }

  // Widget MaxPriceSlider() {
  //   return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
  //     builder: (context, state) {
  //       return Column(
  //         children: [
  //           Text('Maximal price: ${maxPrice ?? 0}'),
  //           Container(
  //             width: 1000,
  //             height: 39,
  //             child: Slider(
  //               activeColor: primaryColor,
  //               min: 0,
  //               max: 1000,
  //               value: maxPrice?.toDouble() ?? 0,
  //               onChanged: (value) {
  //                 if (minPrice != null && value.toInt() < minPrice!) return;
  //                 maxPrice = value.toInt();
  //                 context
  //                     .read<HotelFiltersBloc>()
  //                     .add(MaxPriceChanged(maxPrice: value.toInt()));
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

}
