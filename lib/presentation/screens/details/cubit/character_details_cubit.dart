import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/use_cases/get_character_homeworld_use_case.dart';
import 'package:starwars/domain/use_cases/get_character_starships_use_case.dart';
import 'package:starwars/domain/use_cases/get_character_vehicles_use_case.dart';

part 'character_details_state.dart';

/// Cubit para la pantalla de detalles del personaje
class CharacterDetailsCubit extends Cubit<CharacterDetailsState> {
  /// Constructor del cubit para la pantalla de detalles del personaje
  CharacterDetailsCubit({
    required this.getCharacterHomeWorldUseCase,
    required this.getCharacterStarshipsUseCase,
    required this.getCharacterVehiclesUseCase,
  }) : super(CharacterDetailsInitialState());

  /// Caso de uso para obtener el planeta de origen del personaje
  final GetCharacterHomeWorldUseCase getCharacterHomeWorldUseCase;

  /// Caso de uso para obtener las naves del personaje
  final GetCharacterStarshipsUseCase getCharacterStarshipsUseCase;

  /// Caso de uso para obtener los vehículos del personaje
  final GetCharacterVehiclesUseCase getCharacterVehiclesUseCase;

  /// Obtiene el planeta de origen del personaje
  Future<void> getCharacterDetails(Character character) async {
    try {
      emit(LoadingCharacterDetails());

      await getCharacterHomeWorldUseCase.execute(character);
      await getCharacterStarshipsUseCase.execute(character);
      await getCharacterVehiclesUseCase.execute(character);

      emit(CharacterDetailsLoaded(character: character));
    } catch (e) {
      emit(ErrorGettingDetails('Error al obtener los detalles del personaje'));
    }
  }
}
