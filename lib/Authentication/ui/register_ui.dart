import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:jaundice_image_detector/Authentication/AuthStateEnum.dart';
import 'package:jaundice_image_detector/Authentication/user_model.dart';
import 'package:jaundice_image_detector/Util/icon_ok_alert.dart';
import 'package:jaundice_image_detector/blocs_manager.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State createState() {
    return _RegisterScreen();
  }
}

class _RegisterScreen extends State<RegisterScreen> {
  late BlocsManager _blocsManager;
  final _motherFormKey = GlobalKey<FormState>();
  final _babyFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confPassController = TextEditingController();
  final TextEditingController _pregnancyController = TextEditingController();
  final TextEditingController _babyAgeController = TextEditingController();
  final TextEditingController _motherAgeController = TextEditingController();
  final TextEditingController _babyWeightController = TextEditingController();
  String? _bloodGroup;
  String? _skin;
  bool _motherSelected = true;

  void _changeButtonColors(bool pos) {
    if (_motherSelected != pos) {
      setState(() {
        _motherSelected = pos;
      });
    }
  }

  Future _register(String email, String password, UserModel user) async {
    final AuthState state = await _blocsManager.register(email, password, user);
    Navigator.pop(context);
    if (state == AuthState.SUCCESS) {
      Navigator.pop(context);
    } else if (state == AuthState.EMAIL_TAKEN) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return IconOkAlert(
                text:
                    "El correo ya se encuntra registrado, intenta iniciando sesión",
                color: Colors.red,
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 60,
                ));
          });
    } else if (state == AuthState.WEAK_PASS) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return IconOkAlert(
                text:
                    "La contraseña es muy debil, procure hacerla mas larga o adicionar otro tipo de caracteres",
                color: Colors.red,
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 60,
                ));
          });
    } else if (state != AuthState.SUCCESS) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return IconOkAlert(
                text: "Error desconocido, intentelo otra vez",
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

  String? getConfPassErrorText(String? value) {
    if (value == null || value.isEmpty) {
      return 'La validación no puede estar vacia';
    }
    if (value != _passController.text) {
      return 'Las contraseñas deben coincidir';
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

  void validateForms(GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {
      UserModel? user;
      try {
        user = UserModel(
            duracionEmbarazo: int.parse(_pregnancyController.text),
            edadBebe: int.parse(_babyAgeController.text),
            edadMadre: int.parse(_motherAgeController.text),
            pesoBebe: double.parse(_babyWeightController.text),
            rh: _bloodGroup!,
            tonoPiel: _skin!);
      } catch (error) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const IconOkAlert(
                  text:
                      "Formulario incorrecto, por favor revise que haya llenado los campos de ambas ventanas correctamente",
                  color: Colors.red,
                  icon: Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 60,
                  ));
            });
      }
      if (user != null) {
        showLoaderDialog(context);
        _register(_emailController.text, _passController.text, user);
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const IconOkAlert(
                text:
                    "Formulario incorrecto, por favor revise que haya llenado todos los campos correctamente",
                color: Colors.red,
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 60,
                ));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    _blocsManager = BlocProvider.of(context);
    final image = Container(
      width: 140,
      height: 140,
      child: const Image(image: AssetImage('assets/img/register.png')),
    );

    final options = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.only(
                          left: 30, right: 30, top: 15, bottom: 15)),
                  backgroundColor: _motherSelected
                      ? MaterialStateProperty.all<Color>(Colors.pink)
                      : MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))))),
              onPressed: () {
                _changeButtonColors(true);
              },
              child: Text(
                'Madre',
                style: TextStyle(
                    color: _motherSelected ? Colors.white : Colors.pink,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6),
              ),
            )),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15)),
              backgroundColor: !_motherSelected
                  ? MaterialStateProperty.all<Color>(Colors.pink)
                  : MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))))),
          onPressed: () {
            _changeButtonColors(false);
          },
          child: Text(
            'Paciente',
            style: TextStyle(
                color: !_motherSelected ? Colors.white : Colors.pink,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6),
          ),
        )
      ],
    );

    final motherForm = Form(
      key: _motherFormKey,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
                validator: (value) {
                  return getEmailErrorText(value);
                },
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Contraseña"),
                validator: (value) {
                  return getPassErrorText(value);
                },
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _confPassController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Confirmación contraseña"),
                validator: (value) {
                  return getConfPassErrorText(value);
                },
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _motherAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Edad madre"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La edad no puede ser vacia';
                  } else if (int.parse(value) < 0) {
                    return "La edad debe ser mayor 0";
                  } else {
                    return null;
                  }
                },
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _pregnancyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Duración embarazo"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La duración no puede ser vacia';
                  } else if (int.parse(value) < 0) {
                    return "El numero de semanas debe ser positivo";
                  } else {
                    return null;
                  }
                },
              )),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              validateForms(_motherFormKey);
            },
            child: const Text('Registrarme'),
          ),
        ],
      ),
    );

    final babyForm = Form(
        key: _babyFormKey,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: DropdownButtonFormField(
                  hint: const Text("RH bebé"),
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  validator: (value) =>
                      value == null ? "Seleccione una opción" : null,
                  value: _bloodGroup,
                  onChanged: (String? newValue) {
                    setState(() {
                      _bloodGroup = newValue;
                    });
                  },
                  items: <String>[
                    'O+',
                    'O-',
                    'A+',
                    'A-',
                    'B+',
                    'B-',
                    'AB+',
                    'AB-'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList())),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _babyAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Edad bebé (semanas)"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La edad no puede ser vacia';
                  } else if (int.parse(value) < 0) {
                    return "El numero de semanas debe ser positivo";
                  } else {
                    return null;
                  }
                },
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _babyWeightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Peso del bebé (gramos)"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El peso no puede ser vacio';
                  } else if (int.parse(value) < 0) {
                    return "El peso debe ser positivo";
                  } else {
                    return null;
                  }
                },
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: DropdownButtonFormField(
                  hint: const Text("Tono de piel"),
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  validator: (value) =>
                      value == null ? "Seleccione una opción" : null,
                  value: _skin,
                  onChanged: (String? newValue) {
                    setState(() {
                      _skin = newValue;
                    });
                  },
                  items: <String>['Claro', 'Medio', 'Oscuro']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList())),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              validateForms(_babyFormKey);
            },
            child: const Text('Registrarme'),
          )
        ]));

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Center(child: Text("BiliApp")),
        ),
        body: ListView(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            children: [
              image,
              Padding(
                  padding: const EdgeInsets.only(top: 40.0), child: options),
              Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: _motherSelected ? motherForm : babyForm)
            ]));
  }
}