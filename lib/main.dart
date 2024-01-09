import 'package:flutter/material.dart';
import 'package:greatplace/Providers/placesList.dart';
import 'package:provider/provider.dart';
import '/screens/tabScreen.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import '/screens/welcomePage.dart';

void main() {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlacesList>(create: (_) => PlacesList()),
      ],
      child: MaterialApp(
        title: 'My App',
        initialRoute: WelcomePage.routeName,
        routes: {
          WelcomePage.routeName: (context) => WelcomePage(),
          TabScreen.routeName: (context) => TabScreen(
                onPageSelected: (int pageIndex) {},
              ),
        },
        home: WelcomePage(),
      ),
    );
  }
}
