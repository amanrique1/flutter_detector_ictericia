import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaundice_image_detector/Classifier/classifier_bloc.dart';
import 'package:jaundice_image_detector/Util/icon_ok_alert.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSelectorScreen extends StatefulWidget {
  @override
  _ImageSelectorScreenState createState() => _ImageSelectorScreenState();
}

class _ImageSelectorScreenState extends State<ImageSelectorScreen> {
  static const String CAMERA = "CAMERA";
  static const String GALLERY = "GALLERY";
  final ClassifierService classifierService = ClassifierService();
  File _image = File("");

  Future<void> _uploadImage() async {
    if (_image.path != "") {
      final bool? response = await classifierService.classifyImage(_image.path);
      Navigator.pop(context);
      if (response == true) {
        debugPrint("------------->Sick<------------");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const IconOkAlert(
                title: "¡Atención!",
                  text:
                      "Tu bebé presenta ciertos signos que podrían indicar la presencia de ictericia. \n Inténtalo de nuevo y en caso de que el resultado sea el mismo, consulta inmediatamente a tu médico",
                  color: Colors.red,
                  icon: Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 60,
                  ));
            });
      } else if (response == false) {
        print("------------->Well<------------");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const IconOkAlert(
                title: "Todo parece bien",
                  text: "Aparentemente, \n tu bebé se ve sano.",
                  color: Colors.green,
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                    size: 60,
                  ));
            });
      } else {
        const snackBar = SnackBar(
            content: Text('Ocurrió un error inesperado inténtelo nuevamente')
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
    }
  }

  Future _getImage(source) async {
    XFile? image;
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    if (statuses[Permission.camera] == PermissionStatus.granted &&
        statuses[Permission.storage] == PermissionStatus.granted) {
      if (source == GALLERY) {
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        image = await ImagePicker().pickImage(source: ImageSource.camera);
      }
      if (image != null) {
        setState(() {
          _image = File(image!.path);
        });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const IconOkAlert(
                title: "Permisos",
                text:
                "Para analizar el paciente necesitamos permisos para acceder a la cámara y al almacenamiento",
                color: Colors.red,
                icon: Icon(
                  Icons.warning,
                  color: Colors.white,
                  size: 60,
                ));
          });
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Galeria'),
                      onTap: () {
                        _getImage(GALLERY);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camara'),
                    onTap: () {
                      _getImage(CAMERA);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
          );
        });
  }

  void showLoaderDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      title:  const Text("Analizando"),
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text(" JaDet no es una aplicación \n de diagnóstico. Si deseas \n un diagnóstico de mayor \n seguridad y confianza, \n consulta a tu médico.")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
        ));

    final buttons = Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.only(
                            left: 30, right: 30, top: 15, bottom: 15)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.indigo.shade200),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))))),
                onPressed: () {
                  _showPicker(context);
                },
                child: const Text(
                  'Subir foto',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6),
                ),
              )),
          if(_image.path != "")
          ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0))))),
            onPressed: () {
              if (_image.path != "") {
                showLoaderDialog(context);
                _uploadImage();
              } else {
                const snackBar = SnackBar(
                  content: Text('Tienes que subir una imagen primero')
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: const Text(
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
        children: [
          const Text(
            "Analizar paciente",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          photo,
          buttons
        ],
      ),
    );
  }

  
}
