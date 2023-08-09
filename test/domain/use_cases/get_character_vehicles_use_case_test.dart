import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/domain/use_cases/get_character_vehicles_use_case.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/mock_runner_test.mocks.dart';

void main() {
  group('Caso de uso: GetCharacterVehiclesUseCase =>', () {
    late GetCharacterVehiclesUseCase getCharacterVehiclesUseCase;
    late MockCharacterRepositoryImpl characterRepository;

    const List<String> dummyVehicles = [
      'Sand Crawler',
      'T-16 skyhopper',
      'X-34 landspeeder',
      'TIE/LN starfighter',
    ];

    setUp(() {
      characterRepository = MockCharacterRepositoryImpl();

      getCharacterVehiclesUseCase = GetCharacterVehiclesUseCase(
        characterRepository,
      );
    });

    test('.execute(Character character)', () async {
      when(characterRepository.getCharacterVehicles(dummyCharacter))
          .thenAnswer((_) async => dummyVehicles);

      await getCharacterVehiclesUseCase.execute(dummyCharacter);

      expect(dummyCharacter.vehicles, dummyVehicles);

      verify(characterRepository.getCharacterVehicles(dummyCharacter));
    });
  });
}
