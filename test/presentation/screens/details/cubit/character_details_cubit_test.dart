import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/data/model/character_model.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/presentation/screens/details/cubit/character_details_cubit.dart';

import '../../../../helpers/dummy_data.dart';
import '../../../../helpers/mock_runner_test.mocks.dart';

class CharacterDetailsMatcher<T> extends Matcher {
  CharacterDetailsMatcher();

  @override
  Description describe(Description description) {
    return description.add("Matches CharacterDetailsState type $T");
  }

  @override
  bool matches(item, Map<dynamic, dynamic> matchState) {
    CharacterDetailsState state = item as CharacterDetailsState;

    return state is T;
  }
}

void main() {
  group('Cubit: CharacterDetailsCubit =>', () {
    late MockGetCharacterHomeWorldUseCase getCharacterHomeWorldUseCaseMock;
    late MockGetCharacterStarshipsUseCase getCharacterStarshipsUseCaseMock;
    late MockGetCharacterVehiclesUseCase getCharacterVehiclesUseCaseMock;

    late CharacterDetailsCubit cubit;

    Character dummyCharacter =
        CharacterModel.fromJson(dummyCharacterJson).toEntity();

    setUp(() {
      getCharacterHomeWorldUseCaseMock = MockGetCharacterHomeWorldUseCase();
      getCharacterStarshipsUseCaseMock = MockGetCharacterStarshipsUseCase();
      getCharacterVehiclesUseCaseMock = MockGetCharacterVehiclesUseCase();

      cubit = CharacterDetailsCubit(
        getCharacterHomeWorldUseCase: getCharacterHomeWorldUseCaseMock,
        getCharacterStarshipsUseCase: getCharacterStarshipsUseCaseMock,
        getCharacterVehiclesUseCase: getCharacterVehiclesUseCaseMock,
      );
    });

    blocTest<CharacterDetailsCubit, CharacterDetailsState>(
      'emite [] cuando se instancia',
      build: () => cubit,
      expect: () => [],
    );

    group(
        '.getCharacterDetails(Character character))',
        () => {
              blocTest<CharacterDetailsCubit, CharacterDetailsState>(
                  'emite [LoadingCharacterDetails, CharacterDetailsLoaded] cuando se ejecuta correctamente',
                  build: () {
                    return cubit;
                  },
                  act: (cubit) async =>
                      cubit.getCharacterDetails(dummyCharacter),
                  expect: () => <Matcher>[
                        CharacterDetailsMatcher<LoadingCharacterDetails>(),
                        CharacterDetailsMatcher<CharacterDetailsLoaded>(),
                      ],
                  verify: (_) async {
                    verify(getCharacterHomeWorldUseCaseMock
                            .execute(dummyCharacter))
                        .called(1);
                    verify(getCharacterStarshipsUseCaseMock
                            .execute(dummyCharacter))
                        .called(1);
                    verify(getCharacterVehiclesUseCaseMock
                            .execute(dummyCharacter))
                        .called(1);
                  }),
              blocTest<CharacterDetailsCubit, CharacterDetailsState>(
                  'emite [LoadingCharacterDetails, ErrorGettingDetails] cuando se ejecuta con error',
                  build: () {
                    when(getCharacterHomeWorldUseCaseMock
                            .execute(dummyCharacter))
                        .thenThrow(
                            Exception('Error al obtener las credenciales'));
                    return cubit;
                  },
                  act: (cubit) async =>
                      cubit.getCharacterDetails(dummyCharacter),
                  expect: () => <Matcher>[
                        CharacterDetailsMatcher<LoadingCharacterDetails>(),
                        CharacterDetailsMatcher<ErrorGettingDetails>(),
                      ],
                  verify: (_) async {
                    verify(getCharacterHomeWorldUseCaseMock
                            .execute(dummyCharacter))
                        .called(1);
                    verifyNever(getCharacterStarshipsUseCaseMock
                        .execute(dummyCharacter));
                    verifyNever(getCharacterVehiclesUseCaseMock
                        .execute(dummyCharacter));
                  })
            });
  });
}
