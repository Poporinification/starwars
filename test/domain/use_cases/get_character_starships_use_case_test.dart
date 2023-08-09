import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/domain/use_cases/get_character_starships_use_case.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/mock_runner_test.mocks.dart';

void main() {
  group('Caso de uso: GetCharacterStarshipsUseCase =>', () {
    late GetCharacterStarshipsUseCase getCharacterStarshipsUseCase;
    late MockCharacterRepositoryImpl characterRepository;

    const List<String> dummyStarships = [
      'CR90 corvette',
      'Star Destroyer',
    ];

    setUp(() {
      characterRepository = MockCharacterRepositoryImpl();

      getCharacterStarshipsUseCase = GetCharacterStarshipsUseCase(
        characterRepository,
      );
    });

    test('.execute(Character character)', () async {
      when(characterRepository.getCharacterStarships(dummyCharacter))
          .thenAnswer((_) async => dummyStarships);

      await getCharacterStarshipsUseCase.execute(dummyCharacter);

      expect(dummyCharacter.starships, dummyStarships);

      verify(characterRepository.getCharacterStarships(dummyCharacter));
    });
  });
}
