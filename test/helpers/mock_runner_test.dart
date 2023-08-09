import 'package:mockito/annotations.dart';
import 'package:starwars/data/respositories/character_repository_impl.dart';
import 'package:starwars/data/respositories/connectivity_repository_impl.dart';
import 'package:starwars/data/respositories/http_repository_impl.dart';
import 'package:starwars/data/respositories/storage_repository_impl.dart';
import 'package:starwars/domain/use_cases/append_characters_to_list_use_case.dart';
import 'package:starwars/domain/use_cases/get_character_homeworld_use_case.dart';
import 'package:starwars/domain/use_cases/get_character_starships_use_case.dart';
import 'package:starwars/domain/use_cases/get_character_vehicles_use_case.dart';
import 'package:starwars/domain/use_cases/get_characters_use_case.dart';
import 'package:starwars/domain/use_cases/get_connectivity_status_use_case.dart';
import 'package:starwars/domain/use_cases/report_character_use_case.dart';
import 'package:starwars/domain/use_cases/toggle_connectivity_status_use_case.dart';

@GenerateNiceMocks([
  //Casos de uso
  MockSpec<GetCharactersUseCase>(),
  MockSpec<ReportCharacterUseCase>(),
  MockSpec<GetCharacterVehiclesUseCase>(),
  MockSpec<GetCharacterHomeWorldUseCase>(),
  MockSpec<GetCharacterStarshipsUseCase>(),
  MockSpec<GetConnectivityStatusUseCase>(),
  MockSpec<AppendCharactersToListUseCase>(),
  MockSpec<ToggleConnectivityStatusUseCase>(),

  /// Repositorios
  MockSpec<CharacterRepositoryImpl>(),
  MockSpec<HTTPRepositoryImpl>(),
  MockSpec<StorageRepositoryImpl>(),
  MockSpec<ConnectivityRepositoryImpl>(),
])
void main() {}
