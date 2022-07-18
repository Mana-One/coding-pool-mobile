import 'dart:io';

import 'package:coding_pool_v0/models/Globals.dart';
import 'package:coding_pool_v0/views/screens/account/UserInfosEditScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFromGalleryScreen extends StatefulWidget {
  const ImageFromGalleryScreen(this.type);

  final type;

  @override
  State<ImageFromGalleryScreen> createState() => _ImageFromGalleryScreenState(this.type);
}

class _ImageFromGalleryScreenState extends State<ImageFromGalleryScreen> {

  String _image = '';
  var imagePicker;
  final type;

  _ImageFromGalleryScreenState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrange.shade900,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfosEditScreen(_image)));
            }
        ),
          title: Text(type == ImageSourceType.camera
              ? "Image from Camera"
              : "Image from Gallery")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                      var image = await imagePicker.pickImage(
                    source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = image.path;
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.red[200]),
                child: _image != null
                    ? Image.asset(
                  _image,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.fitHeight,
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.red[200]),
                  width: 200,
                  height: 200,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
