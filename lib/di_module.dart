import 'package:get_it/get_it.dart';
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
import 'package:starwars/presentation/screens/details/cubit/character_details_cubit.dart';
import 'package:starwars/presentation/screens/details/cubit/report_button_cubit.dart';
import 'package:starwars/presentation/screens/list/cubit/character_list_cubit.dart';
import 'package:starwars/presentation/shared/menu/cubit/menu_cubit.dart';

/// Configura la inyección de dependencias
Future<GetIt> setupDependencyInjection() async {
  final di = GetIt.instance;
  await setupRepositories(di);
  await setupUsesCases(di);
  await setupCubits(di);

  return di;
}

/// Regitro de los repositorios que se utilizarán en la aplicación.
Future<void> setupRepositories(GetIt di) async {
  di
    ..registerSingletonAsync<StorageRepositoryImpl>(
      () async => StorageRepositoryImpl(),
    )
    ..registerSingletonAsync<HTTPRepositoryImpl>(
      () async => HTTPRepositoryImpl(),
    )
    ..registerSingletonAsync<CharacterRepositoryImpl>(
      () async => CharacterRepositoryImpl(
        httpRepository: HTTPRepositoryImpl(),
      ),
      dependsOn: [
        HTTPRepositoryImpl,
      ],
    )
    ..registerSingletonAsync<ConnectivityRepositoryImpl>(
      () async => ConnectivityRepositoryImpl(
        storageRepository: di.get<StorageRepositoryImpl>(),
      ),
      dependsOn: [
        StorageRepositoryImpl,
      ],
    );
}

/// Regitro de los casos de uso que se utilizarán en la aplicación.
Future<void> setupUsesCases(GetIt di) async {
  di
    ..registerSingletonAsync<GetCharactersUseCase>(
      () async => GetCharactersUseCase(
        di.get<CharacterRepositoryImpl>(),
      ),
      dependsOn: [
        CharacterRepositoryImpl,
      ],
    )
    ..registerSingletonAsync<AppendCharactersToListUseCase>(
      () async => AppendCharactersToListUseCase(),
    )
    ..registerSingletonAsync<GetCharacterHomeWorldUseCase>(
      () async => GetCharacterHomeWorldUseCase(
        di.get<CharacterRepositoryImpl>(),
      ),
      dependsOn: [
        CharacterRepositoryImpl,
      ],
    )
    ..registerSingletonAsync<GetCharacterStarshipsUseCase>(
      () async => GetCharacterStarshipsUseCase(
        di.get<CharacterRepositoryImpl>(),
      ),
      dependsOn: [
        CharacterRepositoryImpl,
      ],
    )
    ..registerSingletonAsync<GetCharacterVehiclesUseCase>(
      () async => GetCharacterVehiclesUseCase(
        di.get<CharacterRepositoryImpl>(),
      ),
      dependsOn: [
        CharacterRepositoryImpl,
      ],
    )
    ..registerSingletonAsync<ReportCharacterUseCase>(
      () async => ReportCharacterUseCase(
        di.get<CharacterRepositoryImpl>(),
      ),
      dependsOn: [
        CharacterRepositoryImpl,
      ],
    )
    ..registerSingletonAsync<ToggleConnectivityStatusUseCase>(
      () async => ToggleConnectivityStatusUseCase(
        di.get<ConnectivityRepositoryImpl>(),
      ),
      dependsOn: [
        ConnectivityRepositoryImpl,
      ],
    )
    ..registerSingletonAsync<GetConnectivityStatusUseCase>(
      () async => GetConnectivityStatusUseCase(
        di.get<ConnectivityRepositoryImpl>(),
      ),
      dependsOn: [
        ConnectivityRepositoryImpl,
      ],
    );
}

/// Regitro de los cubits que se utilizarán en la aplicación.
Future<void> setupCubits(GetIt di) async {
  di
    ..registerSingletonWithDependencies<CharacterListCubit>(
      () => CharacterListCubit(
        getCharactersUseCase: di.get<GetCharactersUseCase>(),
        appendCharactersToListUseCase: di.get<AppendCharactersToListUseCase>(),
      ),
      dependsOn: [
        GetCharactersUseCase,
        AppendCharactersToListUseCase,
      ],
    )
    ..registerSingletonWithDependencies<CharacterDetailsCubit>(
      () => CharacterDetailsCubit(
        getCharacterHomeWorldUseCase: di.get<GetCharacterHomeWorldUseCase>(),
        getCharacterStarshipsUseCase: di.get<GetCharacterStarshipsUseCase>(),
        getCharacterVehiclesUseCase: di.get<GetCharacterVehiclesUseCase>(),
      ),
      dependsOn: [
        GetCharacterHomeWorldUseCase,
        GetCharacterStarshipsUseCase,
        GetCharacterVehiclesUseCase,
      ],
    )
    ..registerSingletonWithDependencies<MenuCubit>(
      () => MenuCubit(
        toggleConnectivityStatusUseCase:
            di.get<ToggleConnectivityStatusUseCase>(),
        getConnectivityStatusUseCase: di.get<GetConnectivityStatusUseCase>(),
      ),
      dependsOn: [
        ToggleConnectivityStatusUseCase,
        GetConnectivityStatusUseCase,
      ],
    )
    ..registerSingletonWithDependencies<ReportButtonCubit>(
      () => ReportButtonCubit(
        getConnectivityStatusUseCase: di.get<GetConnectivityStatusUseCase>(),
        reportCharacterUseCase: di.get<ReportCharacterUseCase>(),
      ),
      dependsOn: [
        GetConnectivityStatusUseCase,
        ReportCharacterUseCase,
      ],
    );
}

/// Comprueba si la inyección de dependencias se ha inicializado.
Future<void> checkIfDIInitialized(GetIt di) {
  return di.allReady();
}
