import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/domain/use_cases/get_character_homeworld_use_case.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/mock_runner_test.mocks.dart';

void main() {
  group('Caso de uso: GetCharacterHomeWorldUseCase  =>', () {
    late GetCharacterHomeWorldUseCase getCharacterHomeWorldUseCase;
    late MockCharacterRepositoryImpl characterRepository;

    const String dummyHomeworld = 'Tatooine';

    setUp(() {
      characterRepository = MockCharacterRepositoryImpl();

      getCharacterHomeWorldUseCase = GetCharacterHomeWorldUseCase(
        characterRepository,
      );
    });

    test('.execute(Character character)', () async {
      when(characterRepository.getCharacterHomeWorld(dummyCharacter))
          .thenAnswer((_) async => dummyHomeworld);

      await getCharacterHomeWorldUseCase.execute(dummyCharacter);

      expect(dummyCharacter.homeworld, dummyHomeworld);

      verify(characterRepository.getCharacterHomeWorld(dummyCharacter));
    });
  });
}
