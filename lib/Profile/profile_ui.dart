import 'package:flutter/material.dart';
import 'package:jaundice_image_detector/Authentication/AuthStateEnum.dart';
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
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _skinColorController = TextEditingController();

  String? _bloodGroup;
  String? _skin;
  bool _motherSelected = true;
  bool _emailEdit = false;
  bool _passwordEdit = false;
  bool _pregnancyEdit = false;
  bool _babyAgeEdit = false;
  bool _motherAgeEdit = false;
  bool _babyWeightEdit = false;
  bool _bloodGroupEdit = false;
  bool _skinEdit = false;

  Stream<int> getUserData() async* {
    final UserModel? user = await _bloc.getUser();
    if (user != null) {
      _emailController.text = _bloc.getAuthUserEmail();
      _emailController.selection = TextSelection.fromPosition(
          TextPosition(offset: _emailController.text.length));
      _pregnancyController.text = user.pregnancy.toString();
      _pregnancyController.selection = TextSelection.fromPosition(
          TextPosition(offset: _pregnancyController.text.length));
      _babyAgeController.text = user.babyAge.toString();
      _babyAgeController.selection = TextSelection.fromPosition(
          TextPosition(offset: _babyAgeController.text.length));
      _motherAgeController.text = user.motherAge.toString();
      _motherAgeController.selection = TextSelection.fromPosition(
          TextPosition(offset: _motherAgeController.text.length));
      _babyWeightController.text = user.babyWeight.toString();
      _babyWeightController.selection = TextSelection.fromPosition(
          TextPosition(offset: _babyWeightController.text.length));
      _bloodGroupController.text = user.bloodGroup;
      _skinColorController.text = user.skin;
      _bloodGroup = user.bloodGroup;
      _skin = user.skin;
      yield 1;
    }
  }

  void _signOut() {
    _bloc.signOut();
  }

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
              child: const Text("Actualizando")),
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

  void validateForms() {
    final GlobalKey<FormState> key =
        _motherSelected ? _motherFormKey : _babyFormKey;
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
                  title: "Formulario incorrecto",
                  text:
                      "Por favor revise que haya llenado los campos de ambas ventanas correctamente",
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
        _bloc
            .update(_emailEdit ? _emailController.text : null,
                _passwordEdit ? _passController.text : null, user)
            .then((value) {
          Navigator.pop(context);
          if (value == AuthState.SUCCESS) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const IconOkAlert(
                      title: "Actualizado",
                      text: "La información se modificó satisfactoriamente",
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 60,
                      ),
                      color: Colors.green);
                });
          } else if (value == AuthState.UNKNOWN) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const IconOkAlert(
                      title: "Error en el sevidor",
                      text:
                          "Hubo un problema actualizando los datos, intentelo de nuevo",
                      color: Colors.red,
                      icon: Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 60,
                      ));
                });
          } else if (value == AuthState.EMAIL_TAKEN) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const IconOkAlert(
                      title: "Email en uso",
                      text: "Ya existe otra cuenta con ese email",
                      color: Colors.red,
                      icon: Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 60,
                      ));
                });
          } else if (value == AuthState.WEAK_PASS) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const IconOkAlert(
                      title: "Contraseña insegura",
                      text: "La contraseña no es valida, intente con otra",
                      color: Colors.red,
                      icon: Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 60,
                      ));
                });
          }
        });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const IconOkAlert(
                title: "Formulario incorrecto",
                text:
                    "Por favor revise que haya llenado todos los campos correctamente",
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
                      ? MaterialStateProperty.all<Color>(Colors.blue.shade300)
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
                    color: _motherSelected ? Colors.white : Colors.blue.shade400,
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
                  ? MaterialStateProperty.all<Color>(Colors.blue.shade300)
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
                color: !_motherSelected ? Colors.white : Colors.blue.shade400,
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
                readOnly: !_emailEdit,
                controller: _emailController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Email",
                    suffixIcon: _emailEdit
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                _emailEdit = true;
                              });
                            },
                          )),
                validator: (value) {
                  return getEmailErrorText(value);
                },
              )),
          if (_passwordEdit)
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Contraseña",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: () {
                          setState(() {
                            _passwordEdit = false;
                          });
                        },
                      )),
                  validator: (value) {
                    return getPassErrorText(value);
                  },
                )),
          if (_passwordEdit)
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: _confPassController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmación Contraseña"),
                  validator: (value) {
                    return getConfPassErrorText(value);
                  },
                )),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                readOnly: !_motherAgeEdit,
                controller: _motherAgeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Edad madre",
                    suffixIcon: _motherAgeEdit
                        ? null
                        : IconButton(
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
                readOnly: !_pregnancyEdit,
                controller: _pregnancyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Duración embarazo",
                    suffixIcon: _pregnancyEdit
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                _pregnancyEdit = true;
                              });
                            },
                          )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La duración no puede ser vacia';
                  } else if (int.parse(value) < 0) {
                    return "El numero debe ser positivo";
                  } else {
                    return null;
                  }
                },
              )),
          if (!_passwordEdit)
            InkWell(
              onTap: () {
                setState(() {
                  _passwordEdit = true;
                });
              },
              child: const Text(
                "¿Olvidaste tu contraseña? Cambiala",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          Visibility(
              visible: _passwordEdit ||
                  _emailEdit ||
                  _motherAgeEdit ||
                  _pregnancyEdit ||
                  _babyAgeEdit ||
                  _babyWeightEdit ||
                  _bloodGroupEdit ||
                  _skinEdit,
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  validateForms();
                },
                child: const Text('Actualizar'),
              )),
        ],
      ),
    );

    final _bloodGroupInput = TextFormField(
      readOnly: true,
      controller: _bloodGroupController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Tipo de sangre",
          suffixIcon: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _bloodGroupEdit = true;
              });
            },
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Debe seleccionar un grupo';
        } else {
          return null;
        }
      },
    );

    final _bloodGroupDown = DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Tipo de sangre",
        ),
        validator: (value) => value == null ? "Seleccione una opción" : null,
        value: _bloodGroup,
        onChanged: (String? newValue) {
          setState(() {
            _bloodGroup = newValue;
          });
        },
        items: <String>['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());

    final _skinColorInput = TextFormField(
      readOnly: true,
      controller: _skinColorController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Tono de piel",
          suffixIcon: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _skinEdit = true;
              });
            },
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El tono de piel no puede ser vacío';
        } else {
          return null;
        }
      },
    );

    final _skinColorDown = DropdownButtonFormField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: "Tono de piel"),
        validator: (value) => value == null ? "Seleccione una opción" : null,
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
        }).toList());

    final babyForm = Form(
        key: _babyFormKey,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: !_bloodGroupEdit ? _bloodGroupInput : _bloodGroupDown),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                readOnly: !_babyAgeEdit,
                controller: _babyAgeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Edad bebé(semanas)",
                    suffixIcon: _babyWeightEdit
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                _babyAgeEdit = true;
                              });
                            },
                          )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La edad no puede ser vacia';
                  } else if (int.parse(value) < 0) {
                    return "El numero debe ser positivo";
                  } else {
                    return null;
                  }
                },
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                readOnly: !_babyWeightEdit,
                controller: _babyWeightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Peso del bebé (gramos)",
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          _babyWeightEdit = true;
                        });
                      }),
                ),
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
              child: _skinEdit ? _skinColorDown : _skinColorInput),
        ]));

    return StreamBuilder(
      stream: getUserData(),
      builder: (context, stream) {
        if (stream.hasData) {
          return Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("Configuraciones",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                    )),
                    Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: options),
                    Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: _motherSelected ? motherForm : babyForm),
                    if (_passwordEdit ||
                        _emailEdit ||
                        _motherAgeEdit ||
                        _pregnancyEdit ||
                        _babyAgeEdit ||
                        _babyWeightEdit ||
                        _bloodGroupEdit ||
                        _skinEdit)
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          validateForms();
                        },
                        child: const Text('Actualizar'),
                      ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            _signOut();
                          },
                          child: const Text('Cerrar Sesión'),
                        ))
                  ]));
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

        //Theme(

        //);
      },
    );
  }
}
