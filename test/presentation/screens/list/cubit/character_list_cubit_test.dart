import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/data/model/character_model.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/entities/character_record.dart';
import 'package:starwars/presentation/screens/list/cubit/character_list_cubit.dart';

import '../../../../helpers/dummy_data.dart';
import '../../../../helpers/mock_runner_test.mocks.dart';

class CharacterListMatcher<T> extends Matcher {
  CharacterListMatcher();

  @override
  Description describe(Description description) {
    return description.add("Matches CharacterListState type $T");
  }

  @override
  bool matches(item, Map<dynamic, dynamic> matchState) {
    CharacterListState state = item as CharacterListState;

    return state is T;
  }
}

void main() {
  group('Cubit: CharacterListCubit =>', () {
    late MockAppendCharactersToListUseCase appendCharactersToListUseCase;
    late MockGetCharactersUseCase getCharactersUseCase;

    late CharacterListCubit cubit;

    Character dummyCharacter =
        CharacterModel.fromJson(dummyCharacterJson).toEntity();
    int page = 1;
    PagingController<int, Character> pagingController =
        PagingController(firstPageKey: page);

    Recordset dummyRecordset = Recordset(
      count: 1,
      next: '',
      previous: '',
      results: [dummyCharacter],
    );

    setUp(() {
      appendCharactersToListUseCase = MockAppendCharactersToListUseCase();
      getCharactersUseCase = MockGetCharactersUseCase();

      cubit = CharacterListCubit(
        appendCharactersToListUseCase: appendCharactersToListUseCase,
        getCharactersUseCase: getCharactersUseCase,
      );
    });

    blocTest<CharacterListCubit, CharacterListState>(
      'emite [] cuando se instancia',
      build: () => cubit,
      expect: () => [],
    );

    group(
        '.getCharacters(int page, PagingController<int, Character> pagingController)',
        () => {
              blocTest<CharacterListCubit, CharacterListState>(
                  'emite [GettingCharacters, CharactersLoaded] cuando se ejecuta correctamente',
                  build: () {
                    when(getCharactersUseCase.execute(page))
                        .thenAnswer((_) async => dummyRecordset);
                    when(appendCharactersToListUseCase.execute(
                            dummyRecordset, pagingController))
                        .thenAnswer((_) async => pagingController);

                    return cubit;
                  },
                  act: (cubit) async =>
                      cubit.getCharacters(page, pagingController),
                  expect: () => <Matcher>[
                        CharacterListMatcher<GettingCharacters>(),
                        CharacterListMatcher<CharactersLoaded>(),
                      ],
                  verify: (_) async {
                    verify(getCharactersUseCase.execute(page)).called(1);
                    verify(appendCharactersToListUseCase.execute(
                            dummyRecordset, pagingController))
                        .called(1);
                  }),
              blocTest<CharacterListCubit, CharacterListState>(
                  'emite [GettingCharacters, ErrorGettingCharacters] cuando se ejecuta con error',
                  build: () {
                    when(getCharactersUseCase.execute(page)).thenThrow(
                        Exception('Error al obtener las credenciales'));
                    return cubit;
                  },
                  act: (cubit) async =>
                      cubit.getCharacters(page, pagingController),
                  expect: () => <Matcher>[
                        CharacterListMatcher<GettingCharacters>(),
                        CharacterListMatcher<ErrorGettingCharacters>(),
                      ],
                  verify: (_) async {
                    verify(getCharactersUseCase.execute(page)).called(1);
                    verifyNever(appendCharactersToListUseCase.execute(
                        dummyRecordset, pagingController));
                  })
            });
  });
}
