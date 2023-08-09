import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/domain/entities/connetivity.dart';
import 'package:starwars/domain/use_cases/report_character_use_case.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/mock_runner_test.mocks.dart';

void main() {
  group('Caso de uso: ReportCharacterUseCase =>', () {
    late ReportCharacterUseCase reportCharacterUseCase;
    late MockCharacterRepositoryImpl mockCharacterRepositoryImpl;

    Connectivity connectivity = Connectivity(
      hasConnection: true,
    );

    setUp(() {
      mockCharacterRepositoryImpl = MockCharacterRepositoryImpl();

      reportCharacterUseCase = ReportCharacterUseCase(
        mockCharacterRepositoryImpl,
      );
    });

    test('.execute(Character character)', () async {
      when(mockCharacterRepositoryImpl.reportCharacter(dummyCharacter))
          .thenAnswer((_) async => connectivity);

      expect(dummyCharacter.isReported, false);

      await reportCharacterUseCase.execute(dummyCharacter);

      expect(dummyCharacter.isReported, true);

      verify(mockCharacterRepositoryImpl.reportCharacter(dummyCharacter));
    });
  });
}
