import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/domain/entities/character_record.dart';
import 'package:starwars/domain/use_cases/get_characters_use_case.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/mock_runner_test.mocks.dart';

void main() {
  group('Caso de uso: GetCharactersUseCase  =>', () {
    late GetCharactersUseCase getCharacterHomeWorldUseCase;
    late MockCharacterRepositoryImpl characterRepository;

    const int dummyPage = 1;
    Recordset dummyCharacters = Recordset(
      count: 1,
      next: '',
      previous: '',
      results: [dummyCharacter],
    );

    setUp(() {
      characterRepository = MockCharacterRepositoryImpl();

      getCharacterHomeWorldUseCase = GetCharactersUseCase(
        characterRepository,
      );
    });

    test('.execute(int page)', () async {
      when(characterRepository.getCharacters(dummyPage))
          .thenAnswer((_) async => dummyCharacters);

      expect(await getCharacterHomeWorldUseCase.execute(dummyPage),
          dummyCharacters);

      verify(characterRepository.getCharacters(dummyPage));
    });
  });
}
