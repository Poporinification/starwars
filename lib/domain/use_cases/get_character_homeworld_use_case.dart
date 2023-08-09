import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/repositories/character_repository.dart';

/// Caso de uso para obtener los personajes
class GetCharacterHomeWorldUseCase {
  /// Constructor del caso de uso
  GetCharacterHomeWorldUseCase(this.repository);

  /// Instancia del repositorio de personajes
  final CharacterRepository repository;

  /// Ejecuta el caso de uso
  Future<void> execute(Character character) async {
    if (character.hasHomeworlDescription) {
      return;
    }

    character.homeworld = await repository.getCharacterHomeWorld(character);
  }
}
