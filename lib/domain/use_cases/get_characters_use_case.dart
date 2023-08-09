import 'package:starwars/domain/entities/character_record.dart';
import 'package:starwars/domain/repositories/character_repository.dart';

/// Caso de uso para obtener los personajes
class GetCharactersUseCase {
  /// Constructor del caso de uso
  GetCharactersUseCase(this.repository);

  /// Instancia del repositorio de personajes
  final CharacterRepository repository;

  /// Ejecuta el caso de uso
  Future<Recordset> execute(int page) async {
    return await repository.getCharacters(page);
  }
}
