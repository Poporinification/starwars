import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/entities/recordset.dart';
import 'package:starwars/domain/use_cases/append_characters_to_list_use_case.dart';

import '../../helpers/dummy_data.dart';

void main() {
  group('Caso de uso: AppendCharactersToListUseCase  =>', () {
    late AppendCharactersToListUseCase appendCharactersToListUseCase;

    Recordset dummyCharacters = Recordset(
      count: 1,
      next: null,
      previous: null,
      results: [dummyCharacter],
    );

    Recordset dummyCharactersWithNextPage = Recordset(
      count: 1,
      next: 'https://swapi.dev/api/people/?page=2',
      previous: 'https://swapi.dev/api/people/?page=1',
      results: [dummyCharacter],
    );

    PagingController<int, Character> pagingController =
        PagingController(firstPageKey: 1);

    setUp(() {
      appendCharactersToListUseCase = AppendCharactersToListUseCase();
    });

    test(
        '.execute(Recordset recordset, PagingController<int, Character> pagingController)',
        () async {
      await appendCharactersToListUseCase.execute(
        dummyCharacters,
        pagingController,
      );

      expect(pagingController.itemList, [dummyCharacter]);

      await appendCharactersToListUseCase.execute(
        dummyCharactersWithNextPage,
        pagingController,
      );

      expect(pagingController.itemList, [dummyCharacter, dummyCharacter]);
    });
  });
}
