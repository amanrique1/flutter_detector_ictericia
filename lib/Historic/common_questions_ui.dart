import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonQuestionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("JaDet"),
    ),
    body: Container(
    padding:
    const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
    child: ListView(
    children: [
      const Padding(
          padding: EdgeInsets.only(bottom: 10),
        child:Text(
        "Preguntas frecuentes",
        textAlign: TextAlign.center,
        style:
        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)
      )),
      Text(
        "¿Por qué la piel de mi bebé se ve amarilla?" ,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
      const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
          child: Text(
        "\u2022 Es muy probable que tu bebé presente una coloración amarilla en su piel, ojos y mucosas si tiene pocos días de nacido o si es prematuro. Es posible que esta coloración esté o no esté asociada con una patología. Para el primer caso, hay diferentes condiciones o enfermedades que pueden tornar amarilla la piel de tu bebé, como pueden ser: hiperbilirrubinemia, incompatibilidad entre el grupo sanguíneo del bebé y la madre, infección en la sangre del bebé, carencia de enzimas, nacimiento pretérmino, poca ingesta de leche materna, problemas genéticos e incluso infecciones bacterianas como la hepatitis o la cirrosis. Sin embargo, JaDet solo maneja una presunción de diagnóstico para ictericia causada por hiperbilirrubinemia. Si deseas descartar alguna otra enfermedad o condición, consulta a tu médico. ",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
    Text(
        "¿Qué hacer en caso que el diagnóstico de mi bebé sea ictericia?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
      const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
          child: Text(
        "\u2022 En caso de que la presunción de diagnóstico arrojado por JaDet sea ictericia, mantén la calma. Vuelve a intentar con otra imagen y si el resultado persiste, puedes contactar a tu médico para hacer un control.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "¿Cuántas mediciones puedo realizar al día?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 No existe un límite del número de mediciones en el día.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "¿Cómo debería ser el espacio (iluminación, encuadre) de la fotografía para obtener un mejor resultado?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 Para obtener un mejor resultado en el diagnóstico, se recomienda que el espacio donde se tome la fotografía esté iluminado con luz blanca. De igual manera, que la fotografía sea únicamente del rostro del bebé. Evitar que el fondo sea amarillo o naranja.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "¿Qué tan preciso es el diagnóstico de la aplicación?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 JaDet tiene una precisión en su presunción de diagnóstico de un 85-90%.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "¿Las imágenes de mi bebé se van a publicar en algún lado?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 No, las imágenes del bebé serán confidenciales, no se guardarán ni publicarán.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "Si el diagnóstico de mi bebé resulta en ictericia pero no se ve amarillo, ¿qué debo hacer?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 En este caso, vuelva a tomar la medición ajustando la iluminación del espacio de manera que el rostro de su bebé quede lo más enfocado e iluminado posible. Si después de tomar nuevamente la medición, el resultado sigue siendo positivo para ictericia, consulte con su médico.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "¿Este diagnóstico reemplaza la medición de bilirrubina séricos? (Toma de muestra sanguínea)",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 El propósito de JaDet es favorecer la toma de exámenes sanguíneos solo cuando estos sean realmente necesarios. Por consiguiente, no los reemplazan, pero sí permiten llevar un registro controlado de las mediciones de ictericia del neonato.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "¿Qué tan seguido debo realizar el seguimiento de mi bebe? ",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 La aplicación permite que hagas un seguimiento de tu bebé tan seguido como lo desees o como tu doctor te lo indique. Pueden haber factores que aumentan la posibilidad de que tu bebé padezca de ictericia, como si fue prematuro o si hay incompatibilidad con el grupo sanguíneo de la madre.  Sin embargo, puedes discutir estos factores con tu pediatra para determinar el mejor seguimiento.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "¿En qué momento es más probable que se presente ictericia?  ",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 En bebés nacidos a término el pico máximo ocurre entre las primeras 48 y 72 horas de vida, y en pretérmino entre 4 y 5 días. Sin embargo, cuando la ictericia es patológica puede aparecer desde las primeras 24 horas.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "¿A partir de la imagen, se puede determinar si la ictericia es patológica?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 No, JaDet brinda un diagnóstico presuntivo, pero a partir de la imagen no se puede determinar si la ictericia es patológica. Para eso, se deben realizar exámenes sanguíneos. De esa forma, es posible evaluar los niveles de bilirrubina séricos y de esa forma determinar si la ictericia es patológica o no. ",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "Aparte de la coloración amarilla ¿qué otros síntomas podría presentar mi bebé en un escenario de ictericia patológica?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 Además de la coloración amarilla, si tu bebé no desea succionar, tenga débil succión, llore mucho, esté irritable, no orine muy seguido, tenga mal olor en la orina y/o duerme mucho, es posible que tu bebé tenga ictericia patológica y deberías consultar a tu médico.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      )),
      const Text(
        "¿Puedo hacer uso de JaDet si mi bebé se encuentra en una incubadora?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
        const Padding(padding: EdgeInsets.only(top:5,left: 15,bottom: 10),
            child: Text(
        "\u2022 Sí claro, pero ten presente las recomendaciones de captura: utilizar un fondo blanco, enfocar la cara de tu bebé y tomar la captura o seleccionar una foto en la que el rostro de tu bebé esté en posición vertical.",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.justify,
      ))
    ])
    ));
  }
}