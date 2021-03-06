import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_search/hotel_search_repository.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';

import '../shared/constants/colours.dart';
import '../shared/divider.dart';
import '../shared/spinner.dart';
import '../shared/utils.dart';
import 'hotel_list_bloc.dart';
import 'hotel_list_event.dart';
import 'hotel_list_navigator_cubit.dart';
import 'hotel_list_repository.dart';
import 'hotel_list_state.dart';

// final List<String> hotels = [
//   'Bohema Boutique Hotel & Spa',
//   'Campanile Bydgoszcz',
//   'Mariott Bydgoszcz',
//   'Hilton Bydgoszcz',
//   'Hotel a',
//   'Hotel b',
//   'Hotel c',
//   'Hotel d',
// ];

class HotelListView extends StatelessWidget {
  HotelListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HotelListBloc(
          hotelListRepository: context.read<HotelListRepository>(),
        )..add(
            /// TODO: przeniesc maxprice z filtrow tutaj!!!
            LoadOfferList(
              cityId: context.read<HotelSearchRepository>().destinationId!,
              startDate: context.read<HotelSearchRepository>().startDate,
              endDate: context.read<HotelSearchRepository>().endDate,
            ),
          ),
        child: Container(
          decoration: backgroundDecoration,
          width: 1000,
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                containerAppBar(context, 'Search results', true),
                textFieldDivider,
                SizedBox(height: 20),
                _chosenOptionsTile(context),
                SizedBox(height: 5),
                Center(
                  child: _filtersButton(context),
                ),
                SizedBox(height: 20),
                // SizedBox(height: 490, child: hotelsList()),
                hotelsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget hotelsList() {
    return BlocBuilder<HotelListBloc, HotelListState>(
        builder: (context, state) {
      return state.isOfferListLoading
          ? defaultGuestaySpinner()
          : SizedBox(height: 520, child: hotelBuilder());
    });
  }

  Widget hotelBuilder() {
    return BlocBuilder<HotelListBloc, HotelListState>(
        builder: (context, state) {
      return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: context.read<HotelListRepository>().offersList.length,
        itemBuilder: (BuildContext context, int index) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'You chose ${context.read<HotelListRepository>().offersList.elementAt(index)}'),
                ));
                context.read<HotelListNavigatorCubit>().confirmSelectedHotel(
                    context
                        .read<HotelListRepository>()
                        .offersList
                        .elementAt(index));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Center(
                      child: Image.asset(
                    'assets/images/${context.read<HotelListRepository>().offersList.elementAt(index).name!.toLowerCase()}.jpg',
                    // width: 150,
                    // height: 300,
                  ))),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 100,
                height: 30,
                child: Material(
                  elevation: 30,
                  child: Center(
                    child: Text(
                      context
                          .read<HotelListRepository>()
                          .offersList
                          .elementAt(index)
                          .name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _chosenOptionsTile(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        width: 500,
        height: 70,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(hotelSearchRepository.destination != null
                ? hotelSearchRepository.destination!
                : 'Error'),
            textFieldDivider,
            Row(
              children: [
                Text('Dates: ${formatDate(hotelSearchRepository)}'),
                SizedBox(width: 15),
                Text('Guests: ${formatGuestNumber(hotelSearchRepository)}'),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _filtersButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: primaryColor, elevation: 0),
      onPressed: () {
        _filtersButtonPressed(context);
      },
      child: Text('Select filters'),
    );
  }

  void _filtersButtonPressed(BuildContext context) {
    context.read<HotelListNavigatorCubit>().showHotelFilters();
  }
}
