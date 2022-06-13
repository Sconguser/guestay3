import 'package:flutter/material.dart';
import 'package:guestay/shared/bottom_navigation_bar.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/shared/constants/colours.dart';

List<String> destinations = ['Greece', 'Iceland', 'Ireland', 'Italy', 'Morawy'];
List<String> experiences = [
  'Bydgoszcz',
  'Benalmadena',
  'Rome',
  'Berlin',
  'Kuala Lumpur'
];

class SessionView extends StatelessWidget {
  SessionView({Key? key}) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: defaultBottomNavigationBar,
        body: Container(
            decoration: backgroundDecoration,
            width: 1000,
            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications_none_outlined,
                            color: Colors.white, size: 40),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Notifications')));
                        },
                      ),
                      SizedBox(width: 10)
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      _searchBar(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Discover hotels in top destinations',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    // textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 150, child: destinationsBuilder),
                  SizedBox(height: 20),
                  Text('Discover experience',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: experiencesBuilder,
                  )
                ],
              ),
            )));
  }

  ListView destinationsBuilder = ListView.builder(
    physics: ClampingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: destinations.length,
    itemBuilder: (BuildContext context, int index) =>
        Stack(alignment: Alignment.bottomCenter, children: [
      InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('You chose ${destinations.elementAt(index)}'),
          ));
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Center(
                child: Image.asset(
              'assets/images/${destinations.elementAt(index).toLowerCase()}.jpg',
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
                destinations.elementAt(index),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    ]),
  );

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
          borderRadius: BorderRadius.circular(30), color: primaryColor),
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
