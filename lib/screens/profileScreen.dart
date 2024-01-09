import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profileScreen';
  ProfileScreen._private();
  static ProfileScreen? _singleInstance;

  factory ProfileScreen() {
    _singleInstance ??= ProfileScreen._private();
    return _singleInstance!;
  }
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen'),
    );
  }
}
