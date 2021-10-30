import 'package:flutter/material.dart';
import 'package:jaundice_image_detector/Authentication/user_model.dart';
import 'package:jaundice_image_detector/Profile/profile_bloc.dart';
import 'package:jaundice_image_detector/Util/icon_ok_alert.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileBloc _bloc = ProfileBloc();
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
  bool _emailEdit = false;
  bool _passwordEdit = false;
  bool _pregnancyEdit = false;
  bool _babyAgeEdit = false;
  bool _motherAgeEdit = false;
  bool _babyWeightEdit = false;

  void _changeButtonColors(bool pos) {
    if (_motherSelected != pos) {
      setState(() {
        _motherSelected = pos;
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
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Verificando")),
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
        //_update(_emailController.text, _passController.text, user);
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
                  const EdgeInsets.only(
                      left: 30, right: 30, top: 15, bottom: 15)),
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
                readOnly: true,
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
                readOnly: true,
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
                readOnly: true,
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
                readOnly: true,
                controller: _motherAgeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Edad madre",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          _motherAgeEdit = true;
                        });
                      },
                    )),
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
                readOnly: true,
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
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
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
                readOnly: true,
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
                readOnly: true,
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
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
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

    return ListView(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
        children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("Configuraciones",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          )),
          Padding(padding: const EdgeInsets.only(top: 20.0), child: options),
          Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: _motherSelected ? motherForm : babyForm)
        ]);
  }
}
