import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaundice_image_detector/iconOkAlert.dart';
import 'package:jaundice_image_detector/service.dart';

class ImageSelectorScreen extends StatefulWidget {
  @override
  _ImageSelectorScreenState createState() => _ImageSelectorScreenState();
}

class _ImageSelectorScreenState extends State<ImageSelectorScreen> {
  static const String CAMERA = "CAMERA";
  static const String GALLERY = "GALLERY";
  File _image = File("");

  Future _uploadImage() async {
    if (_image.path != "") {
      var response = await ImageService.uploadFile(_image.path);
      if (response.data['jaundice']) {
        print("------------->Sick<------------");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return IconOkAlert(
                  text:
                      "El paciente podría tener ictericia, intentelo otra vez o consulte a su médico",
                  color: Colors.red,
                  icon: Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 60,
                  ));
            });
      } else {
        print("------------->Well<------------");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return IconOkAlert(
                  text: "El paciente se ve sano",
                  color: Colors.green,
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                    size: 60,
                  ));
            });
      }
    }
  }

  Future _getImage(source) async {
    var image;
    if (source == GALLERY) {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria'),
                      onTap: () {
                        _getImage(GALLERY);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camara'),
                    onTap: () {
                      _getImage(CAMERA);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final photo = Container(
        width: 300,
        height: 300,
        child: GestureDetector(
          onTap: () {
            _showPicker(context);
          },
          child: _image.path != ""
              ? Image.file(
                  _image,
                  width: 300,
                  height: 300,
                  fit: BoxFit.fitHeight,
                )
              : Container(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: Icon(Icons.camera_alt,
                      color: Colors.grey[800], size: 60.0),
                ),
        )
    );

    final buttons = Container(
      margin: EdgeInsets.only(top: 20.0, left: 20.0),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(
                            left: 30, right: 30, top: 15, bottom: 15)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))))),
                onPressed: () {
                  _showPicker(context);
                },
                child: Text(
                  'Subir foto',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6),
                ),
              )),
          ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))))),
            onPressed: () {
              _uploadImage();
            },
            child: Text(
              'Analizar',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6),
            ),
          )
        ],
      ),
    );

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(
          "Analizar paciente",
          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
        ),photo, buttons],
      ),
    );
  }
}
