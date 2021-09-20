import 'package:flutter/material.dart';


class IconOkAlert extends StatelessWidget {

  const IconOkAlert({Key? key, required this.text, required this.color, required this.icon}) : super(key: key);

  final String text;
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          clipBehavior: Clip.none, alignment: Alignment.topCenter,
          children: [
            Container(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(text, style: TextStyle(fontSize: 20),),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: () {
                      Navigator.of(context).pop();
                    },
                      style: ElevatedButton.styleFrom(
                      primary: color, // background
                      onPrimary: Colors.white, // foreground
                      ),
                      child: Text('OK'),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 60,
                  child: icon
                )
            ),
          ],
        )
    );
  }
}