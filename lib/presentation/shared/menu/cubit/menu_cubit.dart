import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwars/domain/observable/connection_observable.dart';
import 'package:starwars/domain/use_cases/get_connectivity_status_use_case.dart';
import 'package:starwars/domain/use_cases/toggle_connectivity_status_use_case.dart';

part 'menu_state.dart';

/// Cubit para el menú
class MenuCubit extends Cubit<MenuState> {
  /// Constructor del cubit para el menú
  MenuCubit({
    required this.toggleConnectivityStatusUseCase,
    required this.getConnectivityStatusUseCase,
  }) : super(MenuInitialState());

  /// Caso de uso para cambiar el estado de la conexión
  ToggleConnectivityStatusUseCase toggleConnectivityStatusUseCase;

  /// Caso de uso para obtener el estado de la conexión
  GetConnectivityStatusUseCase getConnectivityStatusUseCase;

  /// Cambia el estado de la conexión
  bool toggleConnectivityStatus({
    required bool isConnected,
    required ConnectionObservable connectionObservable,
  }) {
    toggleConnectivityStatusUseCase.execute(
      isConnected: isConnected,
      connectionObservable: connectionObservable,
    );

    return isConnected;
  }

  /// Obtiene el estado de la conexión
  Future<void> getConnectivityStatus() async {
    try {
      emit(LoadingStoredConnectivityStatus());
      final connectivity = await getConnectivityStatusUseCase.execute();
      emit(StoredConnectivityStatusLoaded(
        isConnected: connectivity.hasConnection,
      ));
    } catch (e) {
      emit(ErrorLoadingStoredConnectivityStatus(
          'Error al obtener el estado de la conexión'));
    }
  }
}
