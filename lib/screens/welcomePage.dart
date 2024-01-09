import 'package:flutter/material.dart';
import 'package:greatplace/Providers/placesList.dart';
import 'package:greatplace/screens/homeScreen.dart';
import 'package:greatplace/screens/tabScreen.dart';

import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  static const routeName = 'welcomeRoute';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _toggleColor = false;

  @override
  Widget build(BuildContext context) {
    // final placesList = Provider.of<PlacesList>(context, listen: false);
    // // log(placesList.items.toString());
    // print(placesList.items.toString());
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.6,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.6,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 101, 50, 244),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(80))),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Images/location1.png',
                      cacheHeight: 280,
                      cacheWidth: 230,
                      scale: 0.9,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Greate Places',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              )
            ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.66,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 101, 50, 244),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.66,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome in service',
                        style: TextStyle(
                            fontFamily: 'PublicSans',
                            letterSpacing: 1,
                            wordSpacing: 2,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Search the places do you want, take pictures and upload here along with their location',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'PublicSans',
                              letterSpacing: 1,
                              fontSize: 17,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: !_toggleColor
                                ? Colors.deepPurpleAccent
                                : const Color.fromARGB(255, 155, 129, 227)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _toggleColor = true;
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => TabScreen(
                                        onPageSelected: (int) {},
                                      )),
                            );

                            // Navigator.of(context)
                            //     .pushNamed(TabScreen.routeName);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 80.0),
                            child: Text(
                              'Get Start',
                              style: TextStyle(
                                  fontFamily: 'PublicSans',
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
