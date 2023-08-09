import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/repositories/character_repository.dart';

/// Caso de uso para reportar un personaje
class ReportCharacterUseCase {
  /// Constructor del caso de uso
  ReportCharacterUseCase(this.characterRepository);

  /// Instancia del repositorio de personajes
  final CharacterRepository characterRepository;

  /// Ejecuta el caso de uso
  Future<void> execute(Character character) async {
    await characterRepository.reportCharacter(character);
    character.isReported = true;
  }
}
