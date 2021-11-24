import 'package:flutter/material.dart';

class TermsConditionsAlert extends StatelessWidget {
  const TermsConditionsAlert(
      {Key? key,
      required this.acceptCallback,
      required this.denyCallback})
      : super(key: key);

  final VoidCallback acceptCallback;
  final VoidCallback denyCallback;

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

  Widget contentBox(BuildContext context) {
    return Container(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: ListView(
            children: <Widget>[
              const Text(
                "Términos y condiciones de uso",
                style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Estas Condiciones de uso rigen el uso que haces de JaDet y proporcionan información sobre el Servicio, en los términos descritos a continuación. Cuando creas una cuenta o usas la plataforma, aceptas estas condiciones.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const Text(
                "Compromisos que asumes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const Text(
                "\u2022 Tu cuenta no debe haberse inhabilitado anteriormente a causa de una infracción de la ley o de cualquiera de nuestras políticas. \n \u2022 No realices actividades ilegales, engañosas o fraudulentas, ni con fines ilegales o no autorizados. \n \u2022 No puedes vender ni adquirir cuentas o datos que hayas obtenido a través de nosotros o nuestro Servicio \n \u2022 No puedes publicar información privada confidencial, incluido propiedad intelectual e industrial, realizar infracciones relacionadas con los derechos de autor o marca, falsificaciones o artículos pirateados.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const Text(
                "Permisos que nos concedes.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const Text(
                "\u2022 No reclamamos la propiedad de tu contenido, pero nos concedes una licencia para usarlo.\n\u2022 Aceptas que podemos descargar e instalar actualizaciones del Servicio en tu dispositivo.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const Text(
                "Política de datos",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const Text(
                "¿Qué información proporcionas?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const Text(
                "\u2022 Información y contenido que nos proporcionas: Recopilamos el contenido y otros datos que proporcionas cuando usas nuestro Productos, por ejemplo, cuando te registras para crear una cuenta, creas un registro y lo envías a algún contacto. Esta información puede corresponder a datos incluidos en el contenido que proporcionas (por ejemplo, los metadatos) o relacionados con los diagnosticas realizados, como el resultado o la fecha de creación de un archivo.\n\u2022 Información sobre transacciones realizadas en nuestro Producto: Si efectúas compras u otras transacciones económicas, para los planes de suscripción, recopilamos datos sobre dichas compras o transacciones. Esos datos incluyen la información del pago, como el número de tu tarjeta de crédito o débito y otra información sobre la tarjeta, así como datos sobre la cuenta y la autenticación, y detalles de facturación, envío y contacto.\n\u2022 Tu uso. Recopilamos información sobre cómo usas nuestro producto, como las funciones que utilizas, las acciones que llevas a cabo, los contactos con que interactúas y la hora, la frecuencia y la duración de tus actividades.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const Text(
                "¿Qué información recuperamos de tu dispositivo?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const Text(
                "\u2022 Características del dispositivo: información como el sistema operativo, la versión de hardware y software, el nivel de carga de la batería, la potencia de la señal, el espacio de almacenamiento disponible, el tipo de navegador, los tipos y nombres de aplicaciones o archivos, y los plugin.\n\u2022 Datos de la configuración del dispositivo: información que nos permites recibir al activar la configuración correspondiente en el dispositivo, como el acceso a la ubicación de GPS, la cámara y las fotos.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 15.0,right: 15.0),
                      child: ElevatedButton(
                          onPressed: denyCallback,
                          child: const Text(
                            "Rechazar",
                            style: TextStyle(fontSize: 18),
                          ))),
                  Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: ElevatedButton(
                      onPressed: acceptCallback,
                      child: const Text(
                        "Aceptar",
                        style: TextStyle(fontSize: 18),
                      )))
                ]),
              ),
            ],
          ));
  }
}
