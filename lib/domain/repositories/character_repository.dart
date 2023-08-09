import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/entities/character_record.dart';

/// Interfaz que define los métodos que debe implementar un repositorio de personajes
/// para que pueda ser usado por los casos de uso
abstract class CharacterRepository {
  /// Obtiene los personajes de la API paginados
  Future<Recordset> getCharacters(int page);

  /// Obtiene el planeta de un personaje
  Future<String> getCharacterHomeWorld(Character character);

  /// Obtiene los vehículos de un personaje
  Future<List<String>> getCharacterVehicles(Character character);

  /// Obtiene las naves de un personaje
  Future<List<String>> getCharacterStarships(Character character);

  /// Reporta un personaje
  Future<void> reportCharacter(Character character);
}
