import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greatplace/Providers/placesList.dart';
import 'package:greatplace/screens/LocationInput.dart';
import 'package:greatplace/screens/mapScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as sysPathProvider;
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/addPlaceScreen';
  AddPlaceScreen._private();
  static AddPlaceScreen? _singleInstance;

  factory AddPlaceScreen() {
    _singleInstance ??= AddPlaceScreen._private();
    return _singleInstance!;
  }
  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  File? _storedImage;

  bool flag = false;

  final FocusNode _cityNameNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();

  @override
  void dispose() {
    _placeNameController.dispose();
    _cityNameController.dispose();
    _dateController.dispose();
    _cityNameNode.dispose();
    super.dispose();
  }

  Future<void> _getDirectory(XFile receivedImage) async {
    final appDirectory =
        await sysPathProvider.getApplicationDocumentsDirectory();
    final imageFile = File(receivedImage.path);
    final fileName = path.basename(imageFile.path);
    final storageResponse =
        await imageFile.copy('${appDirectory.path}/$fileName');

    print("Image Added Succesfully at :- $storageResponse");
    setState(() {
      flag = true;
    });
  }

  Future<void> _takeImage() async {
    final XFile? receivedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (receivedImage == null) {
      return;
    }
    setState(() {
      _storedImage = File(receivedImage.path);
    });

    _getDirectory(receivedImage);
  }

  Future<void> _selectImage() async {
    final XFile? receivedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (receivedImage == null) {
      return;
    }
    setState(() {
      _storedImage = File(receivedImage.path);
    });

    _getDirectory(receivedImage);
  }

  void _submitData() {
    if (!(_globalKey.currentState!.validate()) && _storedImage == null) {
      return;
    }
    if (flag == false) {
      //for Image confirmation
      return;
    }
    _globalKey.currentState!.save();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Submitted'),
      duration: Duration(seconds: 3),
      dismissDirection: DismissDirection.startToEnd,
    ));

    print(_placeNameController.text);
    print(_cityNameController.text);
    print(_dateController.text);

    Provider.of<PlacesList>(context, listen: false).addPlacesList(
        _cityNameController.text,
        _placeNameController.text,
        _storedImage!,
        _dateController.text);
    setState(() {
      flag = false;
    });

    _cityNameController.clear();
    _dateController.clear();
    _placeNameController.clear();
    setState(() {
      _storedImage = null;
    });
  }

  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat.yMEd().format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                'Add a new place',
                style: TextStyle(
                  letterSpacing: 1,
                  wordSpacing: 2,
                  fontSize: 24,
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 163, 135, 239),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_cityNameNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Place name missing';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Enter Place Name',
                    counterStyle: TextStyle(
                        fontFamily: 'PublicSans',
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                controller: _placeNameController,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 10,
              child: Divider(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 163, 135, 239),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                focusNode: _cityNameNode,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Enter City Name',
                    counterStyle: TextStyle(
                        fontFamily: 'PublicSans',
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                controller: _cityNameController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'city name missng';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_dateFocusNode);
                },
              ),
            ),
            const SizedBox(
              height: 10,
              child: Divider(),
            ),
            Row(
              children: [
                Container(
                  width: 205,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 163, 135, 239),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    focusNode: _dateFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Date Missing';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: 'Select Date',
                        counterStyle: TextStyle(
                            fontFamily: 'PublicSans',
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                Container(
                  width: 170,
                  child: Center(
                    child: TextButton.icon(
                        onPressed: _showDatePicker,
                        icon: const Icon(
                          Icons.date_range_outlined,
                          size: 30,
                        ),
                        label: const Text(
                          'Select Date',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF7E57C2)),
                        )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
              child: Divider(),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 163, 135, 239),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(5.0)),
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: FittedBox(
                      child: _storedImage == null
                          ? const Center(
                              child: Text(
                                'No Image Taken Yet',
                                style: TextStyle(
                                    color: Colors.black54,
                                    letterSpacing: 1,
                                    fontFamily: 'PublicSans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : Image.file(
                              _storedImage!,
                              fit: BoxFit.contain,
                              height: 190,
                              width: 190,
                            )),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  width: 170,
                  height: 150,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                          onPressed: _takeImage,
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                          ),
                          label: const Text(
                            'Take Image',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF7E57C2)),
                          )), //for access Camera
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton.icon(
                          onPressed:
                              _selectImage, //for Access native device files
                          icon: const Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          label: const Text(
                            'Choose Image',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF7E57C2)),
                          )),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
              child: Divider(),
            ),
            LocationInput.setImage(
              latitude: 0.0,
              longitude: 0.0,
            ),
            const SizedBox(
              height: 35,
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    border: Border.all(
                      color: const Color.fromARGB(255, 87, 28, 249),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: _submitData,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontFamily: 'PublicSans',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
