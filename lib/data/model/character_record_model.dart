import 'package:starwars/data/model/character_model.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/entities/recordset.dart';

/// Modelo de datos para el registro de personaje
class RecordSetModel {
  /// Constructor del modelo de datos
  RecordSetModel({
    required this.count,
    required this.next,
    required this.previous,
    this.results = const [],
  });

  /// Cantidad de items totales
  final int count;

  /// URL del siguiente página
  final String? next;

  /// URL de la página anterior
  final String? previous;

  /// Lista de resultados de personajes
  final List<Character> results;

  /// Constructor para convertir un mapa a un modelo
  factory RecordSetModel.fromJson(Map<String, dynamic> json) {
    return RecordSetModel(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map(
            (e) =>
                CharacterModel.fromJson(e as Map<String, dynamic>).toEntity(),
          )
          .toList(),
    );
  }

  /// Convierte el modelo a una entidad
  Recordset toEntity() {
    return Recordset(
      count: count,
      next: next,
      previous: previous,
      results: results,
    );
  }
}
