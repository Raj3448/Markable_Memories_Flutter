import 'package:flutter/material.dart';

//import 'package:flutter/widgets.dart';

class HomeScreenWidget extends StatelessWidget {
  final singleItem;
  HomeScreenWidget(this.singleItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        alignment: Alignment.center,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurpleAccent,
            radius: 60.0,
            child: CircleAvatar(
              radius: 50.0,
              foregroundImage: FileImage(
                singleItem.image,
              ),
            ),
          ),
          title: Text(singleItem.title),
          subtitle: Text(singleItem.dateTime),
        ),
      ),
    );
  }
}
