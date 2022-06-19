import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_filters/hotel_filters_bloc.dart';
import 'package:guestay/hotel_filters/hotel_filters_state.dart';
import 'package:guestay/shared/constants/background.dart';

import '../hotel_list/hotel_list_navigator_cubit.dart';
import '../shared/appbar.dart';
import '../shared/constants/colours.dart';
import '../shared/divider.dart';
import 'hotel_filters_event.dart';

bool wifi = false;
bool freeParking = false;
bool freeCancellation = false;
bool kitchen = false;
bool washingMachine = false;
bool breakfast = false;
bool ac = false;
bool entirePlace = false;
bool privateRoom = false;
bool sharedRoom = false;
bool hotelRoom = false;
int? minPrice = 0;
int? maxPrice = 0;

MainAxisAlignment defaultMainAxisAlignment = MainAxisAlignment.spaceBetween;
Color checkBoxColor = primaryColor;

class HotelFiltersView extends StatelessWidget {
  const HotelFiltersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black54,
      //     ),
      //   ),
      // ),
      body: BlocProvider(
        create: (context) => HotelFiltersBloc(),
        child: Container(
          decoration: backgroundDecoration,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              containerAppBar(context, 'Filters', true),
              textFieldDivider,
              WifiCheckBox(),
              FreeParkingCheckBox(),
              FreeCancellationCheckBox(),
              KitchenCheckBox(),
              // WashingMachineCheckBox(),
              BreakfastCheckBox(),
              ACCheckBox(),
              EntirePlaceCheckBox(),
              PrivateRoomCheckBox(),
              SharedRoomCheckBox(),
              HotelRoomCheckBox(),
              textFieldDivider,
              // MinPriceTextBox(),
              // MinPriceSlider(),
              // MaxPriceTextBox(),
              MaxPriceSlider(),
              _confirmButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget WifiCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Wifi'),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              wifi = !wifi;
              context
                  .read<HotelFiltersBloc>()
                  .add(WifiChanged(wifi: value ?? !wifi));
            },
            value: wifi,
          ),
        ],
      );
    },
  );
}

Widget FreeParkingCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Free parking'),
          // SizedBox(
          //   width: 50,
          // ),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              freeParking = !freeParking;
              context
                  .read<HotelFiltersBloc>()
                  .add(FreeParkingChanged(freeParking: value ?? !freeParking));
            },
            value: freeParking,
          ),
        ],
      );
    },
  );
}

Widget FreeCancellationCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Free cancellation'),
          // SizedBox(
          //   width: 50,
          // ),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              freeCancellation = !freeCancellation;
              context.read<HotelFiltersBloc>().add(FreeCancellationChanged(
                  freeCancellation: value ?? !freeCancellation));
            },
            value: freeCancellation,
          ),
        ],
      );
    },
  );
}

Widget KitchenCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Kitchen'),
          // SizedBox(
          //   width: 50,
          // ),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              kitchen = !kitchen;
              context
                  .read<HotelFiltersBloc>()
                  .add(KitchenChanged(kitchen: value ?? !kitchen));
            },
            value: kitchen,
          ),
        ],
      );
    },
  );
}

Widget WashingMachineCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Washing machine'),
          // SizedBox(
          //   width: 50,
          // ),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              washingMachine = !washingMachine;
              context.read<HotelFiltersBloc>().add(WashingMachineChanged(
                  washingMachine: value ?? !washingMachine));
            },
            value: washingMachine,
          ),
        ],
      );
    },
  );
}

Widget BreakfastCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Breakfast'),
          // SizedBox(
          //   width: 50,
          // ),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              breakfast = !breakfast;
              context
                  .read<HotelFiltersBloc>()
                  .add(BreakfastChanged(breakfast: value ?? !breakfast));
            },
            value: breakfast,
          ),
        ],
      );
    },
  );
}

Widget ACCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('AC'),
          // SizedBox(
          //   width: 50,
          // ),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              ac = !ac;
              context.read<HotelFiltersBloc>().add(ACChanged(ac: value ?? !ac));
            },
            value: ac,
          ),
        ],
      );
    },
  );
}

Widget EntirePlaceCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Entire place'),
          // SizedBox(
          //   width: 50,
          // ),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              entirePlace = !entirePlace;
              context
                  .read<HotelFiltersBloc>()
                  .add(EntirePlaceChanged(entirePlace: value ?? !entirePlace));
            },
            value: entirePlace,
          ),
        ],
      );
    },
  );
}

Widget PrivateRoomCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Private room'),
          // SizedBox(
          //   width: 50,
          // ),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              privateRoom = !privateRoom;
              context
                  .read<HotelFiltersBloc>()
                  .add(PrivateRoomChanged(privateRoom: value ?? !privateRoom));
            },
            value: privateRoom,
          ),
        ],
      );
    },
  );
}

Widget SharedRoomCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Shared room'),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              sharedRoom = !sharedRoom;
              context
                  .read<HotelFiltersBloc>()
                  .add(SharedRoomChanged(sharedRoom: value ?? !sharedRoom));
            },
            value: sharedRoom,
          ),
        ],
      );
    },
  );
}

Widget HotelRoomCheckBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Hotel room'),
          Checkbox(
            activeColor: checkBoxColor,
            onChanged: (bool? value) {
              hotelRoom = !hotelRoom;
              context
                  .read<HotelFiltersBloc>()
                  .add(HotelRoomChanged(hotelRoom: value ?? !hotelRoom));
            },
            value: hotelRoom,
          ),
        ],
      );
    },
  );
}

Widget MinPriceTextBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        children: [
          Text('Min price'),
          SizedBox(
            width: 50,
          ),
          Container(
            width: 100,
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Min price',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              // validator: (value) => state.isValidPassword ? null : incorrectPassword,
              onChanged: (value) => context
                  .read<HotelFiltersBloc>()
                  .add(MinPriceChanged(minPrice: int.parse(value))),
            ),
          ),
        ],
      );
    },
  );
}

Widget MinPriceSlider() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Column(
        // mainAxisAlignment: defaultMainAxisAlignment,
        children: [
          Text('Minimal price: ${minPrice ?? 0}'),
          // SizedBox(
          //   width: 50,
          // ),
          Container(
            width: 1000,
            height: 37,
            child: Slider(
              activeColor: primaryColor,
              min: 0,
              max: 1000,
              value: minPrice?.toDouble() ?? 0,
              onChanged: (value) {
                if (maxPrice != null && value.toInt() > maxPrice!) {
                  maxPrice = value.toInt();
                  context
                      .read<HotelFiltersBloc>()
                      .add(MaxPriceChanged(maxPrice: value.toInt()));
                }
                minPrice = value.toInt();
                context
                    .read<HotelFiltersBloc>()
                    .add(MinPriceChanged(minPrice: value.toInt()));
              },
            ),
          ),
        ],
      );
    },
  );
}

Widget MaxPriceTextBox() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Row(
        children: [
          Text('Max price'),
          SizedBox(
            width: 50,
          ),
          Container(
            width: 100,
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Max price',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              // validator: (value) => state.isValidPassword ? null : incorrectPassword,
              onChanged: (value) => context
                  .read<HotelFiltersBloc>()
                  .add(MaxPriceChanged(maxPrice: int.parse(value))),
            ),
          ),
        ],
      );
    },
  );
}

Widget MaxPriceSlider() {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
    builder: (context, state) {
      return Column(
        children: [
          Text('Maximal price: ${maxPrice ?? 0}'),
          Container(
            width: 1000,
            height: 39,
            child: Slider(
              activeColor: primaryColor,
              min: 0,
              max: 1000,
              value: maxPrice?.toDouble() ?? 0,
              onChanged: (value) {
                if (minPrice != null && value.toInt() < minPrice!) return;
                maxPrice = value.toInt();
                context
                    .read<HotelFiltersBloc>()
                    .add(MaxPriceChanged(maxPrice: value.toInt()));
              },
            ),
          ),
        ],
      );
    },
  );
}

Widget _confirmButton(BuildContext context) {
  return BlocBuilder<HotelFiltersBloc, HotelFiltersState>(
      builder: (context, state) {
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
            )),
      ),
    );
  });
}

void _confirmButtonPressed(BuildContext context) {
  context.read<HotelListNavigatorCubit>().confirmChosenFilters(
      wifi,
      freeParking,
      freeCancellation,
      kitchen,
      washingMachine,
      breakfast,
      entirePlace,
      privateRoom,
      sharedRoom,
      hotelRoom,
      maxPrice,
      minPrice);
}
