import 'package:flutter/material.dart';
import 'package:guestay/shared/divider.dart';
import 'constants/colours.dart';

AppBar gradientAppBar = AppBar(
  title: const Text('Gradient appbar'),
  titleSpacing: 1,
  elevation: 0,
  flexibleSpace: Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [gradientPrimaryColor, gradientSecondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
  ),
  actions: [
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.notifications_none),
      color: Colors.black,
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search_outlined),
      color: Colors.black,
    )
  ],
);

Widget defaultAppBar(BuildContext context) {
  return AppBar(
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.black54,
      ),
    ),
  );
}

Widget containerAppBar(BuildContext context, String title, bool showLeading) {
  return Center(
    child: Row(
      children: [
        leading(context, showLeading),
        Text(title),
      ],
    ),
  );
}

Widget leading(BuildContext context, showLeading) {
  return showLeading
      ? IconButton(
          iconSize: 20,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            // size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      : SizedBox(
          height: 20,
        );
}

// class MyDefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const MyDefaultAppBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: InkWell(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: Icon(
//           Icons.arrow_back_ios,
//           color: Colors.black54,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(100);
// }
