import 'package:starwars/domain/entities/connetivity.dart';
import 'package:starwars/domain/repositories/connectivity_repository.dart';

/// Caso de uso para obtener el estado de la conectividad
class GetConnectivityStatusUseCase {
  /// Constructor del caso de uso
  GetConnectivityStatusUseCase(this.repository);

  /// Instancia del repositorio de personajes
  final ConnectivityRepository repository;

  /// Ejecuta el caso de uso
  Future<Connectivity> execute() async {
    return await repository.getConnectivityStatus();
  }
}
