import 'package:flutter/material.dart';
import 'package:greatplace/Screens/homeScreen.dart';
import 'package:greatplace/screens/addPlaceScreen.dart';
import 'package:greatplace/screens/cameraScreen.dart';
import 'package:greatplace/screens/mapScreen.dart';
import 'package:greatplace/screens/profileScreen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = 'homeScreen';
  var selectedPageIndex = 0;
  final Function(int) onPageSelected;
  HomeScreen homeObj = HomeScreen();
  CameraScreen camObj = CameraScreen();
  AddPlaceScreen addObj = AddPlaceScreen();
  MapScreen mapObj = MapScreen();
  ProfileScreen profObj = ProfileScreen();

  TabScreen({required this.onPageSelected});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> _pages = [];

  set setIndexOfBottomBar(int index) {
    setState(() {
      widget.selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      widget.homeObj,
      widget.camObj,
      widget.addObj,
      widget.mapObj,
      widget.profObj,
    ];
    super.initState();
  }

  void selectPage(int index) {
    widget.onPageSelected(index);
    setState(() {
      widget.selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedPageIndex < 0 ||
        widget.selectedPageIndex >= _pages.length) {
      return const Center(
        child: Text('Invalid Page Index'),
      );
    }
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 125, 82, 243),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.dashboard,
                        size: 30,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 3, bottom: 15),
                    child: const Text(
                      'Hello, World Travellers',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        fontFamily: 'PublicSans',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: _pages[widget.selectedPageIndex],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          onTap: selectPage,
          selectedItemColor: const Color.fromARGB(255, 125, 82, 243),
          unselectedItemColor: const Color.fromARGB(255, 143, 142, 142),
          showSelectedLabels: true,
          selectedFontSize: 12,
          showUnselectedLabels: true,
          iconSize: 32,
          currentIndex: widget.selectedPageIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_outlined), label: 'Camera'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_sharp), label: 'Add'),
            BottomNavigationBarItem(icon: Icon(Icons.navigation), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
