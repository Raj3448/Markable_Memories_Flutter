import 'package:flutter/material.dart';
import 'package:greatplace/Providers/placesList.dart';
import 'package:greatplace/widgets/homeScreenWidgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';

  HomeScreen._private();
  static HomeScreen? _singleInstance;

  factory HomeScreen() {
    _singleInstance ??= HomeScreen._private();
    return _singleInstance!;
  }

  @override
  Widget build(BuildContext context) {
    final placesList = Provider.of<PlacesList>(context, listen: false);
    return FutureBuilder(
      future: placesList.fetchingAndLaunchingData(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: Text('No places updated yet'),
                )
              : ListView.builder(
                  itemCount: placesList.items.length,
                  itemBuilder: (ctx, index) =>
                      HomeScreenWidget(placesList.items[index]),
                ),
    );
  }
}
