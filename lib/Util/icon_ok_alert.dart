import 'package:flutter/material.dart';


class IconOkAlert extends StatelessWidget {

  const IconOkAlert({Key? key, required this.title, required this.text, required this.color, required this.icon}) : super(key: key);

  final String title;
  final String text;
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context){
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 20,top: 65, right: 20,bottom: 20
          ),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              const SizedBox(height: 15,),
              Text(text,style: const TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              const SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK",style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: color,
              radius: 45,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                  child: icon
              ),
            ),
        ),
      ],
    );
  }
}