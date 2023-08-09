import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/entities/character_record.dart';
import 'package:starwars/domain/use_cases/append_characters_to_list_use_case.dart';
import 'package:starwars/domain/use_cases/get_characters_use_case.dart';

part 'character_list_state.dart';

/// Cubit para la pantalla de listado de personajes
class CharacterListCubit extends Cubit<CharacterListState> {
  /// Constructor del cubit para la pantalla de listado de personajes
  CharacterListCubit({
    required this.getCharactersUseCase,
    required this.appendCharactersToListUseCase,
  }) : super(CharactersListInitialState());

  /// Caso de uso para obtener los personajes
  final GetCharactersUseCase getCharactersUseCase;

  /// Caso de uso para agregar los personajes a la lista
  final AppendCharactersToListUseCase appendCharactersToListUseCase;

  /// Obtiene los personajes y los agrega a la lista de personajes
  Future<void> getCharacters(
    int page,
    PagingController<int, Character> pagingController,
  ) async {
    try {
      emit(GettingCharacters());
      final recordset = await getCharactersUseCase.execute(page);
      await appendCharactersToListUseCase.execute(recordset, pagingController);

      emit(CharactersLoaded(recordSet: recordset));
    } catch (e) {
      emit(ErrorGettingCharacters('Error al obtener los personajes'));
    }
  }
}
