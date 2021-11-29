import 'package:flutter/material.dart';
import 'package:jaundice_image_detector/Classifier/classifier_bloc.dart';

import 'common_questions_ui.dart';

class Historic extends StatelessWidget {
  final ClassifierService _bloc = ClassifierService();

  Stream<Map?> getUserData() async* {
    yield await _bloc.getPredictions();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map?>(
      stream: getUserData(),
      builder: (context, stream) {
        if (stream.hasData) {
          if (stream.data!.isNotEmpty) {
            return ListView.builder(
              // Let the ListView know how many items it needs to build.
              itemCount: stream.data!.length + 2,
              // Provide a builder function. This is where the magic happens.
              // Convert each item into a widget based on the type of item it is.
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Text("Resultados",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                          textAlign: TextAlign.center));
                }else if(index == stream.data!.length + 1){
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CommonQuestionsScreen()));
                    },
                    child: const Text(
                      "¿Tienes dudas de la enfermedad? Esto te puede interesar",
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else{
                final String key =
                    stream.data!.keys.elementAt(index - 1) as String;
                final item = stream.data![key] as bool;

                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(key),
                      subtitle: Text(item ? "Ictericia" : "Sano"),
                    ),
                    const Divider(),
                  ],
                );
                }
              },
            );
          } else {
            return Center(
                child: Column(children: <Widget>[
              const Text("Aún no tienes clasificaciones, anímate a hacerlo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  textAlign: TextAlign.center),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CommonQuestionsScreen()));
                },
                child: const Text(
                  "¿Tienes dudas de la enfermedad? Esto te puede interesar",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ]));
          }
        } else {
          return Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: const Text("Cargando")),
            ],
          ));
        }
      },
    );
  }
}
