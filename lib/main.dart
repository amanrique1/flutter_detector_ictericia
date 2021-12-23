import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:jaundice_image_detector/blocs_manager.dart';
import 'package:jaundice_image_detector/Authentication/ui/login_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: BlocsManager(),
        child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo.shade200,
        accentColor: Colors.teal,
        brightness: Brightness.light

      ),
      darkTheme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Colors.indigo.shade200,
          accentColor: Colors.teal,
          brightness: Brightness.dark
      ),
      home: LogInScreen()
    )
    );
  }
}


