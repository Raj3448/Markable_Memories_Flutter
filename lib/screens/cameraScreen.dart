import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPathProvider;
import 'package:path/path.dart' as path;

class CameraScreen extends StatefulWidget {
  static const routeName = '/camScreen';
  CameraScreen._private();
  static CameraScreen? _singleInstance;

  var _storedImage;

  factory CameraScreen() {
    _singleInstance ??= CameraScreen._private();
    return _singleInstance!;
  }

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  Future<void> _getDirectory(XFile receivedImage) async {
    final appDirectory =
        await sysPathProvider.getApplicationDocumentsDirectory();
    final imageFile = File(receivedImage.path);
    final fileName = path.basename(imageFile.path);
    final storageResponse =
        await imageFile.copy('${appDirectory.path}/$fileName');

    print("Image Added Succesfully at :- $storageResponse");
  }

  Future<void> _takeImage() async {
    final XFile? receivedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (receivedImage == null) {
      return;
    }
    setState(() {
      widget._storedImage = File(receivedImage.path);
    });

    _getDirectory(receivedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
          onPressed: _takeImage,
          icon: const Icon(
            Icons.camera_alt_outlined,
            size: 30,
          ),
          label: const Text(
            'Take Image',
            style: TextStyle(fontSize: 16, color: Color(0xFF7E57C2)),
          )), //for access Camera,
    );
  }
}
