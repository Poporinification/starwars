import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/repositories/character_repository.dart';

/// Caso de uso para obtener el vehículo de un personaje
class GetCharacterVehiclesUseCase {
  /// Constructor del caso de uso
  GetCharacterVehiclesUseCase(this.repository);

  /// Instancia del repositorio de personajes
  final CharacterRepository repository;

  /// Ejecuta el caso de uso
  Future<void> execute(Character character) async {
    if (character.hasVehiclesDescription) {
      return;
    }

    character.vehicles = await repository.getCharacterVehicles(character);
  }
}
