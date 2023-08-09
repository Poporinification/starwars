/// Entidad de personaje de Star Wars
class Character {
  /// Constructor de la clase
  Character({
    this.birthYear = '',
    this.eyeColor = '',
    this.gender = '',
    this.hairColor = '',
    this.height = '',
    this.homeworld = '',
    this.mass = '',
    this.name = '',
    this.starships = const [],
    this.vehicles = const [],
    this.url = '',
  });

  /// Fecha de nacimiento
  String birthYear;

  /// Color de ojos
  String eyeColor;

  /// Género
  String gender;

  /// Color de pelo
  String hairColor;

  /// Altura
  String height;

  /// Planeta de origen (url)
  String homeworld;

  /// Masa
  String mass;

  /// Nombre
  String name;

  /// Naves (url)
  List<String> starships;

  /// Vehículos (url)
  List<String> vehicles;

  /// Url del personaje
  String url;

  /// Fue reportado
  bool isReported = false;

  /// Obtener altura en cm
  String get formattedHeight => '$height cm.';

  /// Obtener peso en Kg
  String get formattedMass => '$mass kg.';

  /// Obtener género
  String get formattedGender {
    switch (gender) {
      case 'female':
        return 'Femenino';
      case 'male':
        return 'Masculino';
      default:
        return 'Otro';
    }
  }

  /// Chequear si se obtuvo el planeta de origen no es una url
  bool get hasHomeworlDescription => !homeworld.contains('http');

  /// Chequear si se obtuvo las naves no es una url
  bool get hasStarshipsDescription =>
      starships.isNotEmpty && !starships.first.contains('http');

  /// Chequear si se obtuvo los vehículos no es una url
  bool get hasVehiclesDescription =>
      vehicles.isNotEmpty && !vehicles.first.contains('http');

  /// Obtener id del personaje
  int get id => int.parse(url.split('/').reversed.elementAt(1));
}
