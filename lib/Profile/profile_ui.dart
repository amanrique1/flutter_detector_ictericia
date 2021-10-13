import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedPos = 0;

  void _changeButtonColors(int pos) {
    if (_selectedPos != pos) {
      setState(() {
        _selectedPos = pos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final options = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15)),
              backgroundColor: _selectedPos == 0
                  ? MaterialStateProperty.all<Color>(Colors.pink)
                  : MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))))),
          onPressed: () {
            _changeButtonColors(0);
          },
          child: Text(
            'Paciente',
            style: TextStyle(
                color: _selectedPos == 0 ? Colors.white : Colors.pink,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15)),
              backgroundColor: _selectedPos == 1
                  ? MaterialStateProperty.all<Color>(Colors.pink)
                  : MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))))),
          onPressed: () {
            _changeButtonColors(1);
          },
          child: Text(
            'Madre',
            style: TextStyle(
                color: _selectedPos == 1 ? Colors.white : Colors.pink,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6),
          ),
        )
      ],
    );

    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const Text(
            "Configuraciones",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          options
        ],
      ),
    );
  }
}
