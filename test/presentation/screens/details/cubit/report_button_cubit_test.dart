import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/data/model/character_model.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/presentation/screens/details/cubit/report_button_cubit.dart';

import '../../../../helpers/dummy_data.dart';
import '../../../../helpers/mock_runner_test.mocks.dart';

class ReportButtonMatcher<T> extends Matcher {
  ReportButtonMatcher();

  @override
  Description describe(Description description) {
    return description.add("Matches ReportButtonState type $T");
  }

  @override
  bool matches(item, Map<dynamic, dynamic> matchState) {
    ReportButtonState state = item as ReportButtonState;

    return state is T;
  }
}

void main() {
  group('Cubit: ReportButtonCubit =>', () {
    late MockGetConnectivityStatusUseCase getConnectivityStatusUseCaseMock;
    late MockReportCharacterUseCase reportCharacterUseCaseMock;

    late ReportButtonCubit cubit;

    Character dummyCharacter =
        CharacterModel.fromJson(dummyCharacterJson).toEntity();

    setUp(() {
      getConnectivityStatusUseCaseMock = MockGetConnectivityStatusUseCase();
      reportCharacterUseCaseMock = MockReportCharacterUseCase();

      cubit = ReportButtonCubit(
        getConnectivityStatusUseCase: getConnectivityStatusUseCaseMock,
        reportCharacterUseCase: reportCharacterUseCaseMock,
      );
    });

    blocTest<ReportButtonCubit, ReportButtonState>(
      'emite [] cuando se instancia',
      build: () => cubit,
      expect: () => [],
    );

    group(
        '.reportCharacter(Character character))',
        () => {
              blocTest<ReportButtonCubit, ReportButtonState>(
                  'emite [ReportingCharacter, CharacterReported] cuando se ejecuta correctamente',
                  build: () {
                    return cubit;
                  },
                  act: (cubit) async => cubit.reportCharacter(dummyCharacter),
                  expect: () => <Matcher>[
                        ReportButtonMatcher<ReportingCharacter>(),
                        ReportButtonMatcher<CharacterReported>(),
                      ],
                  verify: (_) async {
                    verify(reportCharacterUseCaseMock.execute(dummyCharacter))
                        .called(1);
                  }),
              blocTest<ReportButtonCubit, ReportButtonState>(
                  'emite [ReportingCharacter, ErrorReportingCharacter] cuando se ejecuta con error',
                  build: () {
                    when(reportCharacterUseCaseMock.execute(dummyCharacter))
                        .thenThrow(
                            Exception('Error al obtener las credenciales'));
                    return cubit;
                  },
                  act: (cubit) async => cubit.reportCharacter(dummyCharacter),
                  expect: () => <Matcher>[
                        ReportButtonMatcher<ReportingCharacter>(),
                        ReportButtonMatcher<ErrorReportingCharacter>(),
                      ],
                  verify: (_) async {
                    verify(reportCharacterUseCaseMock.execute(dummyCharacter))
                        .called(1);
                  })
            });
  });
}
