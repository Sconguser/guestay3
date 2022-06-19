import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_search/hotel_search_navigator_cubit.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../shared/constants/colours.dart';
import '../shared/divider.dart';
import 'date_picker_cubit.dart';

DateTime? startDate;
DateTime? endDate;

class DatePickerView extends StatelessWidget {
  const DatePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();

    return Scaffold(
        // appBar: AppBar(),
        body: Column(
      children: [
        Container(
            decoration: backgroundDecoration,
            padding: EdgeInsets.all(30),
            width: 500,
            height: 600,
            child: Column(
              children: [
                containerAppBar(context, 'Pick dates', true),
                textFieldDivider,
                SfDateRangePicker(
                  onSelectionChanged: (date) {
                    print(date.value.startDate);
                    startDate = date.value.startDate;
                    endDate = date.value.endDate;
                  },
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange:
                      (hotelSearchRepository.startDate != null &&
                              hotelSearchRepository.endDate != null)
                          ? PickerDateRange(hotelSearchRepository.startDate,
                              hotelSearchRepository.endDate)
                          : PickerDateRange(
                              DateTime.now().subtract(const Duration(days: 4)),
                              DateTime.now().add(const Duration(days: 3))),
                ),
              ],
            )),
        _confirmButton(context),
      ],
    ));
  }

  Widget _confirmButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
          width: 400,
          height: 50,
          child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: primaryColor, elevation: 0),
              onPressed: () {
                _confirmButtonPressed(context);
              },
              child: Text(
                'Confirm',
                style: TextStyle(color: Colors.black),
              ))),
    );
  }

  void _confirmButtonPressed(BuildContext context) {
    if (startDate != null && endDate != null) {
      context
          .read<HotelSearchNavigatorCubit>()
          .confirmChosenDates(startDate!, endDate!);
    }
  }
}
