import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/entities/recordset.dart';

/// Caso de uso para agregar personajes a la lista
class AppendCharactersToListUseCase {
  /// Constructor del caso de uso
  AppendCharactersToListUseCase();

  /// Ejecuta el caso de uso
  Future<void> execute(
    Recordset recordset,
    PagingController<int, Character> pagingController,
  ) async {
    recordset.nextPage.isEmpty
        ? pagingController.appendLastPage(recordset.results)
        : pagingController.appendPage(
            recordset.results,
            int.parse(recordset.nextPage),
          );
  }
}
