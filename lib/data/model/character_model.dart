/// The `CharacterRepositoryImpl` class is an implementation of the `CharacterRepository` interface that
/// retrieves character data from an API using an `HTTPRepository` instance.
import 'package:starwars/domain/entities/character.dart';

/// Modelo de datos para el personaje
class CharacterModel {
  /// Constructor del modelo de datos
  CharacterModel({
    required this.birth_year,
    required this.eye_color,
    required this.gender,
    required this.hair_color,
    required this.height,
    required this.homeworld,
    required this.mass,
    required this.name,
    required this.starships,
    required this.vehicles,
    required this.url,
  });

  /// Año de nacimiento
  final String? birth_year;

  /// Color de ojos
  final String? eye_color;

  /// Género
  final String? gender;

  /// Color de pelo
  final String? hair_color;

  /// Altura
  final String? height;

  /// Planeta natal
  final String? homeworld;

  /// Peso
  final String? mass;

  /// Nombre
  final String? name;

  /// Naves estelares
  final List<String>? starships;

  /// Vehículos
  final List<String>? vehicles;

  /// Url del personaje
  final String? url;

  /// Constructor para convertir un mapa a un modelo
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      birth_year: json['birth_year'] as String,
      eye_color: json['eye_color'] as String,
      gender: json['gender'] as String,
      hair_color: json['hair_color'] as String,
      height: json['height'] as String,
      homeworld: json['homeworld'] as String,
      mass: json['mass'] as String,
      name: json['name'] as String,
      starships: (json['starships'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
      vehicles: (json['vehicles'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
      url: json['url'] as String,
    );
  }

  /// Convierte un modelo a un mapa
  Map<String, dynamic> toJson() {
    return {
      'birth_year': birth_year,
      'eye_color': eye_color,
      'gender': gender,
      'hair_color': hair_color,
      'height': height,
      'homeworld': homeworld,
      'mass': mass,
      'name': name,
      'starships': starships,
      'vehicles': vehicles,
      'url': url,
    };
  }

  /// Convierte un modelo a una entidad
  Character toEntity() => Character(
        birthYear: birth_year ?? '',
        eyeColor: eye_color ?? '',
        gender: gender ?? '',
        hairColor: hair_color ?? '',
        height: height ?? '',
        homeworld: homeworld ?? '',
        mass: mass ?? '',
        name: name ?? '',
        starships: starships ?? [],
        vehicles: vehicles ?? [],
        url: url ?? '',
      );
}
