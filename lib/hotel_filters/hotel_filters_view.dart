import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/hotel_filters/hotel_filters_bloc.dart';
import 'package:guestay/hotel_filters/hotel_filters_state.dart';

import '../hotel_list/hotel_list_navigator_cubit.dart';
import '../shared/constants/colours.dart';
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
int? minPrice;
int? maxPrice;

class HotelFiltersView extends StatelessWidget {
  const HotelFiltersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => HotelFiltersBloc(),
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
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
              MinPriceTextBox(),
              MaxPriceTextBox(),
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
        children: [
          Text('Wifi'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
        children: [
          Text('Free parking'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
        children: [
          Text('Free cancellation'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
        children: [
          Text('Kitchen'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
        children: [
          Text('Washing machine'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
        children: [
          Text('Breakfast'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
        children: [
          Text('AC'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
            onChanged: (bool? value) {
              breakfast = !breakfast;
              context.read<HotelFiltersBloc>().add(ACChanged(ac: value ?? !ac));
            },
            value: breakfast,
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
        children: [
          Text('Entire place'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
        children: [
          Text('Private room'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
        children: [
          Text('Shared room'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
        children: [
          Text('Hotel room'),
          SizedBox(
            width: 50,
          ),
          Checkbox(
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
