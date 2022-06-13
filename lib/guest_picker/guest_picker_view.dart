import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/guest_picker/guest_picker_event.dart';

import '../hotel_search/hotel_search_navigator_cubit.dart';
import '../hotel_search/hotel_search_repository.dart';
import '../shared/constants/colours.dart';
import 'guest_picker_bloc.dart';
import 'guest_picker_state.dart';

int adults = 0;
int children = 0;
int infants = 0;
int pets = 0;

class GuestPicker extends StatelessWidget {
  const GuestPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelSearchRepository hotelSearchRepository =
        context.read<HotelSearchRepository>();

    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => GuestPickerBloc(),
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              _adultPicker(),
              SizedBox(height: 20),
              _childrenPicker(),
              SizedBox(height: 20),
              _infantsPicker(),
              SizedBox(height: 20),
              _petsPicker(),
              SizedBox(height: 200),
              _confirmButton(context),
            ],
          ),
        ),
      ),
    );
  }

  final TextStyle style = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  final Icon minus = const Icon(
    Icons.remove,
    color: Colors.black,
  );
  final Icon plus = const Icon(
    Icons.add,
    color: Colors.black,
  );

  Widget _adultPicker() {
    return BlocBuilder<GuestPickerBloc, GuestPickerState>(
        builder: (context, state) {
      return Row(
        children: [
          Text(
            'Adults:',
            style: style,
          ),
          SizedBox(width: 10),
          OutlinedButton(
            child: minus,
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              fixedSize: const Size(3, 3),
            ),
            onPressed: () {
              adults--;
              context
                  .read<GuestPickerBloc>()
                  .add(AdultsNumberChanged(adults: adults));
            },
          ),
          Text(
            adults.toString(),
            style: style,
          ),
          OutlinedButton(
            child: plus,
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              fixedSize: const Size(3, 3),
            ),
            onPressed: () {
              adults++;
              context
                  .read<GuestPickerBloc>()
                  .add(AdultsNumberChanged(adults: adults));
            },
          )
        ],
      );
    });
  }

  Widget _childrenPicker() {
    return BlocBuilder<GuestPickerBloc, GuestPickerState>(
        builder: (context, state) {
      return Row(children: [
        Text(
          'Children:',
          style: style,
        ),
        SizedBox(width: 10),
        OutlinedButton(
          child: minus,
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const Size(3, 3),
          ),
          onPressed: () {
            children--;
            context
                .read<GuestPickerBloc>()
                .add(ChildrenNumberChanged(children: children));
          },
        ),
        Text(
          children.toString(),
          style: style,
        ),
        OutlinedButton(
          child: plus,
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const Size(3, 3),
          ),
          onPressed: () {
            children++;
            context
                .read<GuestPickerBloc>()
                .add(ChildrenNumberChanged(children: children));
          },
        )
      ]);
    });
  }

  Widget _infantsPicker() {
    return BlocBuilder<GuestPickerBloc, GuestPickerState>(
        builder: (context, state) {
      return Row(children: [
        Text(
          'Infants:',
          style: style,
        ),
        SizedBox(width: 10),
        OutlinedButton(
          child: minus,
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const Size(3, 3),
          ),
          onPressed: () {
            infants--;
            context
                .read<GuestPickerBloc>()
                .add(InfantsNumberChanged(infants: infants));
          },
        ),
        Text(
          infants.toString(),
          style: style,
        ),
        OutlinedButton(
          child: plus,
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const Size(3, 3),
          ),
          onPressed: () {
            infants++;
            context
                .read<GuestPickerBloc>()
                .add(InfantsNumberChanged(infants: infants));
          },
        )
      ]);
    });
  }

  Widget _petsPicker() {
    return BlocBuilder<GuestPickerBloc, GuestPickerState>(
        builder: (context, state) {
      return Row(children: [
        Text(
          'Pets:',
          style: style,
        ),
        SizedBox(width: 10),
        OutlinedButton(
          child: minus,
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const Size(3, 3),
          ),
          onPressed: () {
            pets--;
            context.read<GuestPickerBloc>().add(PetsNumberChanged(pets: pets));
          },
        ),
        Text(
          pets.toString(),
          style: style,
        ),
        OutlinedButton(
          child: plus,
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const Size(3, 3),
          ),
          onPressed: () {
            pets++;
            context.read<GuestPickerBloc>().add(PetsNumberChanged(pets: pets));
          },
        ),
      ]);
    });
  }

  Widget _confirmButton(BuildContext context) {
    return BlocBuilder<GuestPickerBloc, GuestPickerState>(
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
    context
        .read<HotelSearchNavigatorCubit>()
        .confirmChosenGuests(adults, children, pets, infants);
  }
}
