import 'package:flutter/material.dart';
import 'package:jaundice_image_detector/Classifier/classifier_bloc.dart';

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
          stream.data!.forEach((key, value) {
            print(key);
            print(value);
          });
          return ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: stream.data!.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final String key = stream.data!.keys.elementAt(index) as String;
            final item = stream.data![key] as bool;

            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(key),
                  subtitle: Text(item ? "Ictericia" : "Sano"),
                ),
                Divider(),
              ],
            );
          },
        );
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