import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/home/home_event.dart';
import 'package:guestay/home/home_list_repository.dart';
import 'package:guestay/home/home_navigator_cubit.dart';
import 'package:guestay/shared/bottom_navigation_bar.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/shared/constants/colours.dart';
import 'package:guestay/shared/spinner.dart';

import '../hotel_search/hotel_search_repository.dart';
import '../models/city.dart';
import 'home_bloc.dart';
import 'home_state.dart';

// List<String> destinations = ['Greece', 'Iceland', 'Ireland', 'Italy', 'Morawy'];
List<String> experiences = [
  'Bydgoszcz',
  'Benalmadena',
  'Rome',
  'Berlin',
  'Kuala Lumpur'
];

// List<City> destinations = [];

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocProvider(
        create: (context) => HomeBloc(
          homeListRepository: context.read<HomeListRepository>(),
        )..add(LoadCitiesList()),
        child: Container(
            decoration: backgroundDecoration,
            width: 1000,
            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      _searchBar(),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Center(
                    child: Text(
                      'Discover hotels in top destinations',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      // textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10),
                  // BlocListener<HomeBloc, HomeState>(
                  //   listener: (context,state){
                  //     if(state.isHotelListLoading)
                  //
                  //   },
                  //   child: SizedBox(height: 150, child: destinationsBuilder),
                  // ),
                  destinationsList(),
                  SizedBox(height: 40),
                  Center(
                    child: Text('Discover experience',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: experiencesBuilder,
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget destinationsList() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return state.isCityListLoading
          ? defaultGuestaySpinner()
          : SizedBox(height: 150, child: destinationBuilder());
    });
  }
  //
  // ListView destinationsBuilder = ListView.builder(
  //   physics: ClampingScrollPhysics(),
  //   shrinkWrap: true,
  //   scrollDirection: Axis.horizontal,
  //   itemCount: destinations.length,
  //   itemBuilder: (BuildContext context, int index) =>
  //       Stack(alignment: Alignment.bottomCenter, children: [
  //     InkWell(
  //       onTap: () {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text('You chose ${destinations.elementAt(index)}'),
  //         ));
  //         context.read<HotelSearchRepository>().destination =
  //             destinations.elementAt(index).name;
  //         context.read<HotelSearchRepository>().destinationId =
  //             destinations.elementAt(index).id;
  //         context.read<HomeNavigatorCubit>().showHotelSearch();
  //       },
  //       child: Container(
  //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
  //           child: Center(
  //               child: Image.asset(
  //             'assets/images/${destinations.elementAt(index).name!.toLowerCase()}.jpg',
  //             // width: 150,
  //             // height: 300,
  //           ))),
  //     ),
  //     ClipRRect(
  //       borderRadius: BorderRadius.circular(20),
  //       child: Container(
  //         width: 100,
  //         height: 30,
  //         child: Material(
  //           elevation: 30,
  //           child: Center(
  //             child: Text(
  //               destinations.elementAt(index).name!,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(color: Colors.black),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   ]),
  // );

  Widget destinationBuilder() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: context.read<HomeListRepository>().citiesList.length,
        itemBuilder: (BuildContext context, int index) =>
            Stack(alignment: Alignment.bottomCenter, children: [
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'You chose ${context.read<HomeListRepository>().citiesList.elementAt(index)}'),
              ));
              // state.cities.elementAt(index)
              context.read<HotelSearchRepository>().destination = context
                  .read<HomeListRepository>()
                  .citiesList
                  .elementAt(index)
                  .name;
              context.read<HotelSearchRepository>().destinationId = context
                  .read<HomeListRepository>()
                  .citiesList
                  .elementAt(index)
                  .id;
              context.read<HomeNavigatorCubit>().showHotelSearch();
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Center(
                    child: Image.asset(
                  'assets/images/${context.read<HomeListRepository>().citiesList.elementAt(index).name!.toLowerCase()}.jpg',
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
                        .read<HomeListRepository>()
                        .citiesList
                        .elementAt(index)
                        .name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }

  ListView experiencesBuilder = ListView.builder(
    physics: ClampingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: experiences.length,
    itemBuilder: (BuildContext context, int index) =>
        Stack(alignment: Alignment.bottomCenter, children: [
      InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('You chose ${experiences.elementAt(index)}'),
          ));
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Center(
                child: Image.asset(
              'assets/images/${experiences.elementAt(index).toLowerCase()}.jpg',
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
                experiences.elementAt(index),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    ]),
  );

  Widget _searchBar() {
    return Container(
      // color: Colors.blue,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
            border: InputBorder.none,
            // constraints: BoxConstraints(maxWidth: 250),
            hintText: 'Enter a destination',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            )),
      ),
    );
  }
}
