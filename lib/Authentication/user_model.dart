class UserModel {
  final int duracionEmbarazo;
  final int edadBebe;
  final int edadMadre;
  final double pesoBebe;
  final String rh;
  final String tonoPiel;

  //myFavoritePlaces
  //myPlaces

  UserModel({
    required this.duracionEmbarazo,
    required this.edadBebe,
    required this.edadMadre,
    required this.pesoBebe,
    required this.rh,
    required this.tonoPiel
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
    duracionEmbarazo: json['duracionEmbarazo']! as int,
    edadBebe: json['edadBebe']! as int,
    edadMadre: json['edadMadre']! as int,
    pesoBebe: json['pesoBebe']! as double,
    rh: json['rh']! as String,
    tonoPiel: json['tonoPiel']! as String
  );

  Map<String, Object?> toJson() {
    return {
      'duracionEmbarazo': duracionEmbarazo,
      'edadBebe': edadBebe,
      'edadMadre': edadMadre,
      'pesoBebe': pesoBebe,
      'rh': rh,
      'tonoPiel': tonoPiel,
    };
  }

}