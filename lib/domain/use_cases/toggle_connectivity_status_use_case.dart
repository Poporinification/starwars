import 'package:starwars/domain/observable/connection_observable.dart';
import 'package:starwars/domain/repositories/connectivity_repository.dart';

/// Caso de uso para
class ToggleConnectivityStatusUseCase {
  /// Constructor del caso de uso
  ToggleConnectivityStatusUseCase(this.repository);

  /// Instancia del repositorio de personajes
  final ConnectivityRepository repository;

  /// Ejecuta el caso de uso
  Future<void> execute({
    required bool isConnected,
    required ConnectionObservable connectionObservable,
  }) async {
    final hasStoredConnectivityStatus =
        await repository.hasStoredConnectivityStatus();

    if (!hasStoredConnectivityStatus) {
      await repository.saveConnectivityStatus(isConnected);
      connectionObservable.changeConnectionStatus(isConnected);
      return;
    }

    repository.updateConnectivityStatus(isConnected);
    connectionObservable.changeConnectionStatus(isConnected);

    if (isConnected) {
      Future.delayed(const Duration(seconds: 30), () async {
        await repository.updateConnectivityStatus(!isConnected);
        connectionObservable.changeConnectionStatus(!isConnected);
      });
    }
  }
}
