import 'package:starwars/domain/entities/character.dart';

/// Modelo de datos para el registro de personaje
class Recordset {
  /// Constructor del modelo de datos
  Recordset({
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

  /// Indica si es la última página
  bool get isLastPage => next == null;

  /// Indica si es la primera página
  bool get isFirstPage => previous == null;

  /// Obtiene el número de la página siguiente
  String get nextPage => next?.split('=')[1] ?? '';
}
