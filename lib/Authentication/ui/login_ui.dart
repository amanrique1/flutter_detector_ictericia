import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:jaundice_image_detector/Authentication/AuthStateEnum.dart';
import 'package:jaundice_image_detector/blocs_manager.dart';
import 'package:jaundice_image_detector/Authentication/ui/register_ui.dart';
import 'package:jaundice_image_detector/home_page.dart';
import 'package:jaundice_image_detector/Util/icon_ok_alert.dart';

class LogInScreen extends StatefulWidget {
  @override
  State createState() {
    return _LogInScreen();
  }
}

class _LogInScreen extends State<LogInScreen> {
  late BlocsManager _blocsManager;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future _login(String email, String password) async {
    final AuthState state = await _blocsManager.login(email, password);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    if (state == AuthState.WRONG_PASS) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const IconOkAlert(
                title: "Contraseña incorrecta",
                text: "Verifique su clave e intentelo otra vez",
                color: Colors.red,
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 60,
                ));
          });
    } else if (state == AuthState.USER_NOT_FOUND) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const IconOkAlert(
              title: "Usuario no encontrado",
                text: "El correo suministrado no aparece registrado, intentelo otra vez",
                color: Colors.red,
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 60,
                ));
          });
    } else if (state != AuthState.SUCCESS) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const IconOkAlert(
                title: "Error desconocido",
                text: "Hubo un error inesperado, intentelo otra vez",
                color: Colors.red,
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 60,
                ));
          });
    }
  }

  String? getEmailErrorText(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email no puede ser vacio';
    }
    final bool correct = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (correct) {
      return null;
    } else {
      return 'El formato del email no es correcto';
    }
  }

  String? getPassErrorText(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña no puede ser vacia';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener mínimo 8 caracteres';
    }
    // return null if the text is valid
    return null;
  }

  void showLoaderDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text("Verificando")),
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

  Widget _logInContainer(String title) {
    const Widget image = SizedBox(
      width: 250,
      height: 230,
      child: Image(image: AssetImage('assets/img/logojadet.png')),
    );

    final Widget form = Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Email"),
            validator: (value) {
              return getEmailErrorText(value);
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Contraseña"),
                validator: (value) {
                  return getPassErrorText(value);
                },
              )),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            child: const Text(
                "¿No tienes una cuenta? Créala ahora",
              style: TextStyle(
                color:Colors.blue
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.only(
                            left: 30, right: 30, top: 10, bottom: 10)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.indigo.shade200),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))))),
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                showLoaderDialog(context);
                _login(_emailController.text, _passController.text);
              }
            },
            child: const Text('Iniciar Sesión'),
          ),
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Center(child: Text(title)),
          backgroundColor: Colors.indigo.shade200, 
        ),
        body: Container(
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                  Padding(
                      padding: const EdgeInsets.only(top: 30.0), child: form)
                ])));
  }

  @override
  Widget build(BuildContext context) {
    _blocsManager = BlocProvider.of(context);
    return StreamBuilder(
      stream: _blocsManager.user,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //snapshot- data - Object User
        if (!snapshot.hasData || snapshot.hasError) {
          return _logInContainer('JaDet');
        } else {
          debugPrint(snapshot.data.toString());
          return const HomePage(title: 'JaDet');
        }
      },
    );
  }
}